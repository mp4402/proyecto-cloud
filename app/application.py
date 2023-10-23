from flask.helpers import url_for
from flask import Flask, request, redirect, session, jsonify
from jinja2 import Environment, FileSystemLoader
from werkzeug.utils import secure_filename
import os
from datetime import datetime
import psycopg2
import boto3
conn = ""
def openConnection():# Set up a connection to the postgres server.
    global conn
    conn = psycopg2.connect(host="database-1.c4lnyuhwody1.us-east-1.rds.amazonaws.com",
                            user="postgres",
                            port=5432,
                            database="postgres",
                            password="postgres")
    # conn = psycopg2.connect("dbname=postgres user=postgres")

UPLOAD_FOLDER = os.getcwd() + '/static'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

#os.environ['DB_HOST']

File_loader = FileSystemLoader("templates")
env = Environment(loader=File_loader)
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.secret_key = "key"
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

#---------------funciones para unitTesting---------------------------------
def autenticacion():
    if "sesion" in session:
        return True
    else:
        return False

def retornarFecha(fecha_hora):
    return str(fecha_hora.day) + "-" +str(fecha_hora.month) + "-" + str(fecha_hora.year)

def retornarHora(fecha_hora):
    hora = ""
    if fecha_hora.minute < 10:
            hora = str(fecha_hora.hour) + ":0" + str(fecha_hora.minute)
    else:
        hora = str(fecha_hora.hour) + ":" + str(fecha_hora.minute)
    return hora

def fechaActual(currentTime):
    return (currentTime.year * 10000000000) + (currentTime.month * 100000000) +  (currentTime.day * 1000000)

def aMayuscula(records):
    for row in range(len(records)):
        records[row] = list(records[row])
        records[row][4] = (records[row][4]).upper()
        records[row] = tuple(records[row])
    return records

# upload S3
def upload_image(file, image_key, _from):
    s3_client = boto3.client('s3', 
                      aws_access_key_id="", 
                      aws_secret_access_key="", 
                      region_name='us-east-1'
                      )

    BUCKET = "conectadosfiles"
    IMAGE_KEY = image_key
    # Upload in-memory object to S3 bucket
    if (_from == 1):
        s3_client.put_object(Body=file, Bucket=BUCKET, Key=f"UserPhotos/{IMAGE_KEY}", ContentType=file.content_type)
    else:
        s3_client.put_object(Body=file, Bucket=BUCKET, Key=f"EventPhotos/{IMAGE_KEY}", ContentType=file.content_type)






@app.route('/',methods=["GET","POST"])
def index():
    records = ""
    template = env.get_template('index.html')
    logoConectados = url_for('static',filename="conectados2.png")
    css = url_for('static',filename="styles.css")
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT * FROM public.categoria"
    cursor.execute(sql_command, )
    categorias = cursor.fetchall()
    cursor.close()
    conn.close()
    if (request.method == "POST"):
        cate = request.form.get("busqueda")
        cate = int(cate)
        if cate == 0:
            openConnection()
            cursor = conn.cursor()
            sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id);"
            cursor.execute(sql_command, )
            records = cursor.fetchall()
            cursor.close()
            conn.close()
        else:
            openConnection()
            cursor = conn.cursor()
            id = cate
            sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id) WHERE categoria.id = %s;"
            cursor.execute(sql_command, (id, ))
            records = cursor.fetchall()
            cursor.close()
            conn.close()
    else:
        openConnection()
        cursor = conn.cursor()
        sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id);"
        cursor.execute(sql_command, )
        records = cursor.fetchall()
        cursor.close()
        conn.close()
    records = aMayuscula(records)
    if autenticacion() == True:
        return template.render(css = css,logoConectados=logoConectados,records = records, categorias = categorias)
    else:
        return redirect("/inicioSesion")

@app.route('/registro',methods=["GET","POST"], endpoint="registro")
def regristro():
    #Dentro de request 'GET'
    css = url_for('static',filename="registroEstilos.css")
    normalizacioncss = url_for('static',filename="normalize.css")
    logo = url_for('static',filename="conectados.png")
    template = env.get_template('registro.html')
    scriptregistro = url_for('static',filename="scripts.js")
    #Dentro de request 'POST'
    if(request.method == 'POST'):
        #Extracción de los datos del form
        pais = request.form["Pais"] #pais
        nombre = request.form["nombre"] #nombre_usuario
        email = request.form["correo"] #correo
        clave = request.form["clave"] #contrasena
        id_validador = 0
        if 'file' not in request.files:
            print("No se seleccionó ningun archivo 1")
            return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptregistro=scriptregistro,mensaje="")
        file = request.files['file']
        if file.filename == '':
            print("No se seleccionó ningun archivo 2")
            return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptregistro=scriptregistro,mensaje="No seleccionó ninguna imagen")
        if file and allowed_file(file.filename):
            print("Archivo seleccionado")
            filename = nombre + "_" + secure_filename(file.filename)
            upload_image(file, filename, 1)
            path_image = f"https://conectadosfiles.s3.us-east-1.amazonaws.com/UserPhotos/{filename}"
            openConnection()
            cursor = conn.cursor()
            sql_command = "SELECT id FROM public.user_data WHERE  public.user_data.correo = %s;"
            cursor.execute(sql_command, (email, ))
            records = cursor.fetchall()
            for row in records:
                id_validador = row[0]
            cursor.close()
            conn.close()
            if id_validador == 0:
                #INSERT DE INFORMACION DE USUARIO LUEGO DE UN REGISTRO
                openConnection()
                cursor = conn.cursor()
                sql_command = "INSERT INTO public.user_data (correo, contrasena, nombre_usuario, pais, path_foto)VALUES (%s, %s, %s, %s, %s);"
                cursor.execute(sql_command, (email,clave,nombre,pais, path_image, ))
                conn.commit()
                #SELECT DEL ID DEL USUARIO CREADO
                sql_command = "SELECT id FROM public.user_data ORDER BY user_data.id DESC LIMIT 1;"
                cursor.execute(sql_command, )
                records = cursor.fetchall()
                for row in records:
                    print(row)
                    session['sesion'] = row[0]
                cursor.close()
                conn.close()
                return redirect("/") 
            else:
                return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptregistro=scriptregistro,mensaje="¡Correo ya utilizado!")       
        return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptregistro=scriptregistro,mensaje="¡Debes llenar todos los campos!")
    return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptregistro=scriptregistro,mensaje="")

@app.route('/inicioSesion',methods=["GET","POST"], endpoint="inicioSesion")
def inicioSesion():
    css = url_for('static',filename="loginEstilos.css")
    normalizacioncss = url_for('static',filename="normalize.css")
    logo = url_for('static',filename="conectados.png")
    template = env.get_template('login.html')
    #Método POST
    if request.method == 'POST':
        email = request.form["correo"]
        clave = request.form["clave"]
        if email == "" or clave == "":
            return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,mensaje="¡Debes llenar todos los campos!")
        else:
            #SELECT ID DEL USUARIO LOGGIN
            openConnection()
            cursor = conn.cursor()
            sql_command = "SELECT id FROM public.user_data WHERE  public.user_data.correo = %s and public.user_data.contrasena = %s;"
            cursor.execute(sql_command, (email, clave))
            records = cursor.fetchall()
            if records == []:
                return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,mensaje="Correo o contraseña erronea")
            else:
                for row in records:
                    print(row)
                    session['sesion'] = row[0]
                cursor.close()
                conn.close()
                return redirect("/")
    return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,mensaje="")

@app.route('/nueva_actividad',methods=["GET","POST"], endpoint="nueva_actividad")
def nueva_actividad():
    css = url_for('static',filename="nueva_actividad_estilos.css")
    normalizacioncss = url_for('static',filename="normalize.css")
    logo = url_for('static',filename="conectados.png")
    template = env.get_template('nueva_actividad.html')
    scriptNuevaActividad = url_for('static',filename="nueva_actividad_scripts.js")
    #RECIBIR O RECORDAR TENER LE ID DEL USUARIO
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT * FROM public.categoria"
    cursor.execute(sql_command, )
    categorias = cursor.fetchall()
    cursor.close()
    conn.close()
    if request.method == "POST":
        nombre = request.form["nombre"]
        descripcion = request.form["descripcion"]
        categoria = request.form.get("categoria")
        request_fecha = request.form['fecha']
        fecha_hora = datetime.strptime(request_fecha, "%Y-%m-%dT%H:%M")
        fecha = retornarFecha(fecha_hora)
        hora = retornarHora(fecha_hora)
        precio = request.form["precio"]
        if 'file1' not in request.files:
            return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptNuevaActividad=scriptNuevaActividad, categorias = categorias)
        file = request.files['file1']
        if file.filename == '':
            return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptNuevaActividad=scriptNuevaActividad,categorias = categorias)
        if file and allowed_file(file.filename):
            print("Archivo seleccionado")
            filename = nombre + "_fotoPortada_" + secure_filename(file.filename)
            upload_image(file, filename, 2)
            path_image = f"https://conectadosfiles.s3.us-east-1.amazonaws.com/EventPhotos/{filename}"
        #INSERT en la tabla de eventos creados.
        openConnection()
        cursor = conn.cursor()
        sql_command = "INSERT INTO public.evento_data(nombre, description, fecha, hora, precio, path_foto_p)VALUES (%s, %s, %s, %s, %s, %s);"
        cursor.execute(sql_command, (nombre, descripcion, fecha, hora, precio, path_image, ))
        conn.commit()
        #SELECT DEL ID DEL EVENTO CREADO
        sql_command = "SELECT id FROM public.evento_data ORDER BY evento_data.id DESC LIMIT 1;"
        cursor.execute(sql_command, )
        records = cursor.fetchall()
        id_evento = ""
        for row in records:
            id_evento = row[0]
        #--- otro insert
        sql_command = "INSERT INTO public.evento_categoria(id_evento, id_categoria)VALUES(%s, %s);"
        cursor.execute(sql_command, (id_evento, categoria, ))
        id_user = session["sesion"]
        sql_command = "INSERT INTO public.usuario_evento_creado(id_user, id_evento)VALUES (%s, %s);"
        cursor.execute(sql_command, (id_user, id_evento, ))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect("/mis_actividades")
    return template.render(css=css,normalizacioncss=normalizacioncss,logo=logo,scriptNuevaActividad=scriptNuevaActividad,categorias = categorias)

@app.route('/cuenta',methods=["GET","POST"], endpoint="cuenta")#hay un delete/ eliminar cuenta
def cuenta():
    css = url_for('static',filename="cuenta.css")
    template = env.get_template('cuenta.html')
    logo = url_for('static',filename="conectados.png")
    id = ""
    if (request.method == "POST"):
        #DELETE
        #delete en usuario_evento_registrado
        openConnection()
        cursor = conn.cursor()
        id = session["sesion"]
        sql_command = "DELETE FROM public.usuario_evento_registrado WHERE usuario_evento_registrado.id_user = %s"
        cursor.execute(sql_command, (id, ))
        conn.commit()
        cursor.close()
        conn.close()
        #delete en usuario_evento_creado
        openConnection()
        cursor = conn.cursor()
        sql_command = "DELETE FROM public.usuario_evento_creado WHERE usuario_evento_creado.id_user = %s"
        cursor.execute(sql_command, (id, ))
        conn.commit()
        cursor.close()
        conn.close()
        #delete en evento_comentarios
        openConnection()
        cursor = conn.cursor()
        sql_command = "DELETE FROM public.evento_comentarios WHERE evento_comentarios.id_user = %s"
        cursor.execute(sql_command, (id, ))
        conn.commit()
        cursor.close()
        conn.close()
        #delete en evento_data
        openConnection()
        cursor = conn.cursor()
        sql_command = "DELETE FROM public.user_data WHERE user_data.id = %s"
        cursor.execute(sql_command, (id, ))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect("/inicioSesion")
    else:
        openConnection()
        cursor = conn.cursor()
        if "sesion" in session:
            id = session["sesion"]
            sql_command = "SELECT correo, nombre_usuario, pais FROM public.user_data WHERE  public.user_data.id = %s;"
            cursor.execute(sql_command, (id, ))
            records = cursor.fetchall()
            cursor.close()
            conn.close()
            return template.render(css = css, logo = logo, records = records)
        else:
            return redirect("/inicioSesion")

@app.route('/mis_actividades',methods=["GET","POST"], endpoint="mis_actividades")#hay DELETE/ evento registrado por boton. / evento por pasar fecha
def mis_actividades():
    template = env.get_template('mis_actividades.html')
    logo = url_for('static',filename="conectados.png")
    css = url_for('static',filename="mis_actividades.css")
    CREADOS = ""
    REGISTRADOS = ""
    if (request.method == "POST"):
        idActividad = request.form["id"]
        print(f"EL ID DEL EVENTO A BORRAR ES: {idActividad}")
        #DELETE por boton de eliminar evento registrado
        openConnection()
        cursor = conn.cursor()
        sql_command = "DELETE FROM public.usuario_evento_registrado WHERE usuario_evento_registrado.id_evento = %s"
        cursor.execute(sql_command, (idActividad, ))
        conn.commit()
        cursor.close()
        conn.close() 
    #ID DE EVENTOS CREADOS:
    openConnection()
    cursor = conn.cursor()
    id = session["sesion"]
    ids = []
    sql_command = "SELECT id_evento FROM usuario_evento_creado where id_user = %s"
    cursor.execute(sql_command, (id, ))
    records = cursor.fetchall()
    for row in records:
        ids.append(row[0])
    cursor.close()
    conn.close()
    ids = tuple(ids)
    #MIS EVENTOS CREADOS:
    if len(ids) !=0:
        openConnection()
        cursor = conn.cursor()
        sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id) WHERE evento_data.id IN %s;"
        cursor.execute(sql_command, (ids, ))
        CREADOS = cursor.fetchall()
        cursor.close()
        conn.close()    
    #MIS EVENTOS REGISTRADOS IDS
    openConnection()
    cursor = conn.cursor()
    id = session["sesion"]
    ids = []
    sql_command = "SELECT id_evento FROM usuario_evento_registrado where id_user = %s"
    cursor.execute(sql_command, (id, ))
    records = cursor.fetchall()
    for row in records:
        ids.append(row[0])
    cursor.close()
    conn.close()
    #MIS EVENTOS REGISTRADOS
    REGISTRADOS2 = []
    if len(ids) != 0:
        ids = tuple(ids)
        openConnection()
        cursor = conn.cursor()
        sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, evento_data.fecha, evento_data.hora, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id) WHERE evento_data.id IN %s;"
        cursor.execute(sql_command, (ids, ))
        REGISTRADOS = cursor.fetchall()
        currentTime = datetime.now()
        currentTime = fechaActual(currentTime)
        for row in REGISTRADOS:
            fechaEvento = row[4]
            fechaEvento = datetime.strptime(fechaEvento,'%d-%m-%Y')
            fechaEvento = (fechaEvento.year * 10000000000) + (fechaEvento.month * 100000000) +  (fechaEvento.day * 1000000)
            if (currentTime - fechaEvento == 15):
                id_Actividad = row[0]
                #DELETE por fecha
                #DELETE idActividad
                #delete en usuario_evento_registrado
                openConnection()
                cursor = conn.cursor()
                sql_command = "DELETE FROM public.usuario_evento_registrado WHERE usuario_evento_registrado.id_evento = %s"
                cursor.execute(sql_command, (id_Actividad, ))
                conn.commit()
                cursor.close()
                conn.close()
                #delete en usuario_evento_creado
                openConnection()
                cursor = conn.cursor()
                sql_command = "DELETE FROM public.usuario_evento_creado WHERE usuario_evento_creado.id_evento = %s"
                cursor.execute(sql_command, (id_Actividad, ))
                conn.commit()
                cursor.close()
                conn.close()
                #delete en evento_comentarios
                openConnection()
                cursor = conn.cursor()
                sql_command = "DELETE FROM public.evento_comentarios WHERE evento_comentarios.id_evento = %s"
                cursor.execute(sql_command, (id_Actividad, ))
                conn.commit()
                cursor.close()
                conn.close()
                #delete en evento_categoria
                openConnection()
                cursor = conn.cursor()
                sql_command = "DELETE FROM public.evento_categoria WHERE evento_categoria.id_evento = %s"
                cursor.execute(sql_command, (id_Actividad, ))
                conn.commit()
                cursor.close()
                conn.close()
                #delete en evento_data
                openConnection()
                cursor = conn.cursor()
                sql_command = "DELETE FROM public.evento_data WHERE evento_data.id = %s"
                cursor.execute(sql_command, (id_Actividad, ))
                conn.commit()
                cursor.close()
                conn.close()
            else:
                REGISTRADOS2.append(row)
    else:
        pass    
    cursor.close()
    conn.close()
    return template.render(css = css,logo=logo,creados=CREADOS, registrados = REGISTRADOS2)

@app.route('/informacion_actividad/<idActividad>',methods=["GET","POST"], endpoint="informacion_actividad")#tengo que recibir el id del evento seleccionado. 
def informacion_actividad(idActividad=None):
    css = url_for('static',filename="informacion_actividad.css")
    template = env.get_template('informacion_actividad.html')
    logo = url_for('static',filename="conectados.png")
    if (request.method == "POST"):
        if request.form.get('Registrarme') == 'Registrarme':
            openConnection()
            cursor = conn.cursor()
            id_user = session["sesion"]
            id_evento = idActividad
            sql_command = "INSERT INTO public.usuario_evento_registrado(id_user, id_evento) VALUES (%s, %s);"
            cursor.execute(sql_command, (id_user, id_evento, ))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect("/mis_actividades")
        if request.form.get('Comentar') == 'Comentar':
            openConnection()
            cursor = conn.cursor()
            id_evento = idActividad
            id = session["sesion"]
            comentario = request.form["comentario"]
            print(f"comentario: {comentario}")
            sql_command = "INSERT INTO public.evento_comentarios(id_evento, id_user, comentario)VALUES (%s, %s, %s);"
            cursor.execute(sql_command, (id_evento, id, comentario, ))
            conn.commit()
            cursor.close()
            conn.close()
    openConnection()
    cursor = conn.cursor()
    id = idActividad
    sql_command = "SELECT * FROM public.evento_data WHERE evento_data.id = %s;"
    cursor.execute(sql_command, (id, ))
    informacion = cursor.fetchall()
    cursor.close()
    conn.close()  
    openConnection()
    cursor = conn.cursor()
    id = idActividad
    print(id)
    sql_command = "SELECT user_data.nombre_usuario, evento_comentarios.comentario FROM (user_data INNER JOIN evento_comentarios ON user_data.id = evento_comentarios.id_user) where evento_comentarios.id_evento = %s"
    cursor.execute(sql_command, (id, ))
    comentarios = cursor.fetchall()
    print(comentarios)
    cursor.close()
    conn.close()
    return template.render(css = css, logo = logo,informacion = informacion, comentarios = comentarios)

@app.route('/editar_actividad/<idActividad>',methods=["GET","POST"], endpoint="editar_actividad") #idActividad/HAY DELETE/ Comentario y Evento
def editar_actividad(idActividad=None):
    css = url_for('static',filename="editar_actividad.css")
    template = env.get_template('editar_actividad.html')
    logo = url_for('static',filename="conectados.png")
    img1 = url_for('static',filename="hacer1.jpg")
    img2 = url_for('static',filename="hacer2.jpg")
    img3 = url_for('static',filename="hacer3.jpg")
    img4 = url_for('static',filename="hacer4.jpg")
    mensaje =""
    if (request.method == "POST"):
        if request.form.get('eliminar') == 'eliminar':
            #DELETE idActividad
            #delete en usuario_evento_registrado
            openConnection()
            cursor = conn.cursor()
            print(idActividad)
            sql_command = "DELETE FROM public.usuario_evento_registrado WHERE usuario_evento_registrado.id_evento = %s"
            cursor.execute(sql_command, (idActividad, ))
            conn.commit()
            cursor.close()
            conn.close()
            #delete en usuario_evento_creado
            openConnection()
            cursor = conn.cursor()
            sql_command = "DELETE FROM public.usuario_evento_creado WHERE usuario_evento_creado.id_evento = %s"
            cursor.execute(sql_command, (idActividad, ))
            conn.commit()
            cursor.close()
            conn.close()
            #delete en evento_comentarios
            openConnection()
            cursor = conn.cursor()
            sql_command = "DELETE FROM public.evento_comentarios WHERE evento_comentarios.id_evento = %s"
            cursor.execute(sql_command, (idActividad, ))
            conn.commit()
            cursor.close()
            conn.close()
            #delete en evento_categoria
            openConnection()
            cursor = conn.cursor()
            sql_command = "DELETE FROM public.evento_categoria WHERE evento_categoria.id_evento = %s"
            cursor.execute(sql_command, (idActividad, ))
            conn.commit()
            cursor.close()
            conn.close()
            #delete en evento_data
            openConnection()
            cursor = conn.cursor()
            sql_command = "DELETE FROM public.evento_data WHERE evento_data.id = %s"
            cursor.execute(sql_command, (idActividad, ))
            conn.commit()
            cursor.close()
            conn.close()
        if request.form.get('Borrar') == 'Borrar':
            #DELETE idComentario
            idComentario = request.form["idcomentario"]
            openConnection()
            cursor = conn.cursor()
            sql_command = "DELETE FROM public.evento_comentarios WHERE evento_comentarios.id = %s"
            cursor.execute(sql_command, (idComentario, ))
            conn.commit()
            cursor.close()
            conn.close()
            mensaje="Comentario eliminado"
    openConnection()
    cursor = conn.cursor()
    id = idActividad
    sql_command = "SELECT * FROM public.evento_data WHERE evento_data.id = %s;"
    cursor.execute(sql_command, (id, ))
    informacion = cursor.fetchall()
    cursor.close()
    conn.close()
    openConnection()
    cursor = conn.cursor()
    id = idActividad
    sql_command = "SELECT evento_comentarios.id, user_data.nombre_usuario, evento_comentarios.comentario FROM (user_data INNER JOIN evento_comentarios ON user_data.id = evento_comentarios.id_user) where evento_comentarios.id_evento = %s"
    cursor.execute(sql_command, (id, ))
    comentarios = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return template.render(css = css, logo = logo,informacion = informacion, comentarios = comentarios, mensaje=mensaje)

@app.route('/cerrar_sesion',methods=["GET","POST"], endpoint="cerrar_sesion")#hay DELETE/ evento registrado por boton. / evento por pasar fecha
def cerrar_sesion():
    session['sesion'] = False
    return redirect("/inicioSesion")



#----------------------------------------------  Rutas de testing  ---------------------------------------------------------------------------

@app.route('/test_obtener_usuarios',methods=["GET","POST"], endpoint="test_obtener_usuarios")
def test_obtener_usuarios():
    respuesta = ""
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT * FROM public.user_data"
    cursor.execute(sql_command, )
    respuesta = cursor.fetchall()
    cursor.close()
    conn.close()
    if respuesta == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify(respuesta)

@app.route('/test_obtener_eventos',methods=["GET","POST"], endpoint="test_eventos")
def test_eventos():
    respuesta = ""
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT evento_data.id, evento_data.nombre, evento_data.precio, evento_data.path_foto_p, categoria.nombre FROM ((evento_data INNER JOIN evento_categoria ON evento_data.id = evento_categoria.id_evento) INNER JOIN categoria ON evento_categoria.id_categoria = categoria.id);"
    cursor.execute(sql_command, )
    respuesta = cursor.fetchall()
    cursor.close()
    conn.close()
    if respuesta == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify(respuesta)

@app.route('/test_categorias',methods=["GET","POST"], endpoint="test_categorias")
def test_eventos():
    repuesta2 = ""
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT * FROM public.categoria"
    cursor.execute(sql_command, )
    repuesta2 = cursor.fetchall()
    cursor.close()
    conn.close()
    if repuesta2 == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify(repuesta2)

@app.route('/test_id',methods=["GET","POST"], endpoint="test_id")
def test_id():
    email = "javiermazariegos@ufm.edu"
    contraseña = "123"
    id_validador = ""
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT id FROM public.user_data WHERE  public.user_data.correo = %s and public.user_data.contrasena = %s;"
    cursor.execute(sql_command, (email,contraseña ))
    records = cursor.fetchall()
    for row in records:
        id_validador = row[0]
    cursor.close()
    conn.close()
    if id_validador == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify({"id usuario":id_validador})

@app.route('/test_cuenta/<idUsuario>',methods=["GET","POST"], endpoint="test_cuenta")
def test_cuenta(idUsuario=None):
    respuesta3 = ""
    openConnection()
    cursor = conn.cursor()
    sql_command = "SELECT correo, nombre_usuario, pais FROM public.user_data WHERE  public.user_data.id = %s;"
    cursor.execute(sql_command, (idUsuario, ))
    respuesta3 = cursor.fetchall()
    cursor.close()
    conn.close()
    if respuesta3 == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify(respuesta3)

@app.route('/test_obtener_comentario/<idActividad>',methods=["GET","POST"], endpoint="test_obtener_comentario")
def test_obtener_comentario(idActividad=None):
    comentarios = ""
    openConnection()
    cursor = conn.cursor()
    id = idActividad
    sql_command = "SELECT evento_comentarios.id, user_data.nombre_usuario, evento_comentarios.comentario FROM (user_data INNER JOIN evento_comentarios ON user_data.id = evento_comentarios.id_user) where evento_comentarios.id_evento = %s"
    cursor.execute(sql_command, (id, ))
    comentarios = cursor.fetchall()
    cursor.close()
    conn.close()
    if comentarios == "":
        return jsonify({'respuesta':'No hay respuesta'})
    else:
        return jsonify(comentarios)

@app.route('/test_nueva_actividad',methods=["GET","POST"], endpoint="test_nueva_actividad")
def test_nueva_actividad():
    if request.method == "POST":
        req_Json = request.json
        nombre = req_Json["nombre"]
        descripcion = req_Json["descripcion"]
        categoria = req_Json["categoria"]
        fecha_hora = datetime.strptime(req_Json['fecha'], "%Y-%m-%dT%H:%M")
        fecha = str(fecha_hora.day) + "-" +str(fecha_hora.month) + "-" + str(fecha_hora.year)
        if fecha_hora.minute < 10:
            hora = str(fecha_hora.hour) + ":0" + str(fecha_hora.minute)
        else:
            hora = str(fecha_hora.hour) + ":" + str(fecha_hora.minute)
        precio = req_Json["precio"]
        filename = "Excursión entre risas al famoso letrero de Hollywood_fotoPortada_persona2.jpg"
        #INSERT en la tabla de eventos creados.
        openConnection()
        cursor = conn.cursor()
        sql_command = "INSERT INTO public.evento_data(nombre, description, fecha, hora, precio, path_foto_p)VALUES (%s, %s, %s, %s, %s, %s);"
        cursor.execute(sql_command, (nombre, descripcion, fecha, hora, precio, filename, ))
        conn.commit()
        #SELECT DEL ID DEL EVENTO CREADO
        sql_command = "SELECT id FROM public.evento_data ORDER BY evento_data.id DESC LIMIT 1;"
        cursor.execute(sql_command, )
        records = cursor.fetchall()
        id_evento = ""
        for row in records:
            id_evento = row[0]
        #--- otro insert
        sql_command = "INSERT INTO public.evento_categoria(id_evento, id_categoria)VALUES(%s, %s);"
        cursor.execute(sql_command, (id_evento, categoria, ))
        id_user = 2
        sql_command = "INSERT INTO public.usuario_evento_creado(id_user, id_evento)VALUES (%s, %s);"
        cursor.execute(sql_command, (id_user, id_evento, ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'id del evento creado':id_evento})


@app.route('/test_editar_actividad/<idActividad>',methods=["GET","POST"], endpoint="test_editar_actividad")
def test_editar_actividad(idActividad = None):
    openConnection()
    cursor = conn.cursor()
    print(idActividad)
    sql_command = "DELETE FROM public.usuario_evento_registrado WHERE usuario_evento_registrado.id_evento = %s"
    cursor.execute(sql_command, (idActividad, ))
    conn.commit()
    cursor.close()
    conn.close()
    #delete en usuario_evento_creado
    openConnection()
    cursor = conn.cursor()
    sql_command = "DELETE FROM public.usuario_evento_creado WHERE usuario_evento_creado.id_evento = %s"
    cursor.execute(sql_command, (idActividad, ))
    conn.commit()
    cursor.close()
    conn.close()
    #delete en evento_comentarios
    openConnection()
    cursor = conn.cursor()
    sql_command = "DELETE FROM public.evento_comentarios WHERE evento_comentarios.id_evento = %s"
    cursor.execute(sql_command, (idActividad, ))
    conn.commit()
    cursor.close()
    conn.close()
    #delete en evento_categoria
    openConnection()
    cursor = conn.cursor()
    sql_command = "DELETE FROM public.evento_categoria WHERE evento_categoria.id_evento = %s"
    cursor.execute(sql_command, (idActividad, ))
    conn.commit()
    cursor.close()
    conn.close()
    #delete en evento_data
    openConnection()
    cursor = conn.cursor()
    sql_command = "DELETE FROM public.evento_data WHERE evento_data.id = %s"
    cursor.execute(sql_command, (idActividad, ))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'actividad editada':idActividad})





if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port="3000")
