--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.2

-- Started on 2023-10-16 17:20:59 CST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 24604)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 24605)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24610)
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoria_id_seq OWNER TO postgres;

--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 215
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 216 (class 1259 OID 24611)
-- Name: evento_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_categoria (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.evento_categoria OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24614)
-- Name: evento_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evento_categoria_id_seq OWNER TO postgres;

--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 217
-- Name: evento_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_categoria_id_seq OWNED BY public.evento_categoria.id;


--
-- TOC entry 218 (class 1259 OID 24615)
-- Name: evento_comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_comentarios (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    id_user integer NOT NULL,
    comentario text NOT NULL
);


ALTER TABLE public.evento_comentarios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24620)
-- Name: evento_comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_comentario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evento_comentario_id_seq OWNER TO postgres;

--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 219
-- Name: evento_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_comentario_id_seq OWNED BY public.evento_comentarios.id;


--
-- TOC entry 220 (class 1259 OID 24621)
-- Name: evento_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_data (
    id integer NOT NULL,
    nombre text NOT NULL,
    description text NOT NULL,
    fecha text NOT NULL,
    hora text NOT NULL,
    precio numeric NOT NULL,
    path_foto_p text NOT NULL
);


ALTER TABLE public.evento_data OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24626)
-- Name: evento_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evento_data_id_seq OWNER TO postgres;

--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 221
-- Name: evento_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_data_id_seq OWNED BY public.evento_data.id;


--
-- TOC entry 222 (class 1259 OID 24627)
-- Name: evento_fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_fotos (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    path_foto text NOT NULL
);


ALTER TABLE public.evento_fotos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24632)
-- Name: evento_fotos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evento_fotos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evento_fotos_id_seq OWNER TO postgres;

--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 223
-- Name: evento_fotos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_fotos_id_seq OWNED BY public.evento_fotos.id;


--
-- TOC entry 224 (class 1259 OID 24633)
-- Name: user_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_data (
    id integer NOT NULL,
    correo text NOT NULL,
    contrasena text NOT NULL,
    nombre_usuario text NOT NULL,
    pais text NOT NULL,
    path_foto text NOT NULL
);


ALTER TABLE public.user_data OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24638)
-- Name: user_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_data_id_seq OWNER TO postgres;

--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_data_id_seq OWNED BY public.user_data.id;


--
-- TOC entry 226 (class 1259 OID 24639)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24644)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 227
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 228 (class 1259 OID 24645)
-- Name: usuario_evento_creado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_creado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_creado OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24648)
-- Name: usuario_evento_creado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_evento_creado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_evento_creado_id_seq OWNER TO postgres;

--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 229
-- Name: usuario_evento_creado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_evento_creado_id_seq OWNED BY public.usuario_evento_creado.id;


--
-- TOC entry 231 (class 1259 OID 24729)
-- Name: usuario_evento_registrado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_registrado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_registrado OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24728)
-- Name: usuario_evento_registrado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_evento_registrado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_evento_registrado_id_seq OWNER TO postgres;

--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 230
-- Name: usuario_evento_registrado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_evento_registrado_id_seq OWNED BY public.usuario_evento_registrado.id;


--
-- TOC entry 4176 (class 2604 OID 24652)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 4177 (class 2604 OID 24653)
-- Name: evento_categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria ALTER COLUMN id SET DEFAULT nextval('public.evento_categoria_id_seq'::regclass);


--
-- TOC entry 4178 (class 2604 OID 24654)
-- Name: evento_comentarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentarios ALTER COLUMN id SET DEFAULT nextval('public.evento_comentario_id_seq'::regclass);


--
-- TOC entry 4179 (class 2604 OID 24655)
-- Name: evento_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data ALTER COLUMN id SET DEFAULT nextval('public.evento_data_id_seq'::regclass);


--
-- TOC entry 4180 (class 2604 OID 24656)
-- Name: evento_fotos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos ALTER COLUMN id SET DEFAULT nextval('public.evento_fotos_id_seq'::regclass);


--
-- TOC entry 4181 (class 2604 OID 24657)
-- Name: user_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data ALTER COLUMN id SET DEFAULT nextval('public.user_data_id_seq'::regclass);


--
-- TOC entry 4182 (class 2604 OID 24658)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4183 (class 2604 OID 24659)
-- Name: usuario_evento_creado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado ALTER COLUMN id SET DEFAULT nextval('public.usuario_evento_creado_id_seq'::regclass);


--
-- TOC entry 4184 (class 2604 OID 24732)
-- Name: usuario_evento_registrado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado ALTER COLUMN id SET DEFAULT nextval('public.usuario_evento_registrado_id_seq'::regclass);


--
-- TOC entry 4186 (class 2606 OID 24661)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4188 (class 2606 OID 24663)
-- Name: evento_categoria evento_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4190 (class 2606 OID 24665)
-- Name: evento_comentarios evento_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentarios
    ADD CONSTRAINT evento_comentario_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4192 (class 2606 OID 24667)
-- Name: evento_data evento_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data
    ADD CONSTRAINT evento_data_pkey PRIMARY KEY (id);


--
-- TOC entry 4194 (class 2606 OID 24669)
-- Name: evento_fotos evento_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT evento_fotos_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 4196 (class 2606 OID 24671)
-- Name: user_data user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (id);


--
-- TOC entry 4198 (class 2606 OID 24673)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4200 (class 2606 OID 24675)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4202 (class 2606 OID 24677)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4204 (class 2606 OID 24679)
-- Name: usuario_evento_creado usuario_evento_creado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT usuario_evento_creado_pkey PRIMARY KEY (id_user);


--
-- TOC entry 4206 (class 2606 OID 24734)
-- Name: usuario_evento_registrado usuario_evento_registrado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT usuario_evento_registrado_pkey PRIMARY KEY (id_user);


--
-- TOC entry 4214 (class 2606 OID 24740)
-- Name: usuario_evento_registrado fk-evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT "fk-evento" FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 4215 (class 2606 OID 24735)
-- Name: usuario_evento_registrado fk-user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT "fk-user" FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- TOC entry 4207 (class 2606 OID 24682)
-- Name: evento_categoria fk_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id);


--
-- TOC entry 4212 (class 2606 OID 24687)
-- Name: usuario_evento_creado fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 4208 (class 2606 OID 24692)
-- Name: evento_categoria fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 4209 (class 2606 OID 24697)
-- Name: evento_comentarios fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentarios
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 4211 (class 2606 OID 24702)
-- Name: evento_fotos fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 4213 (class 2606 OID 24712)
-- Name: usuario_evento_creado fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- TOC entry 4210 (class 2606 OID 24717)
-- Name: evento_comentarios fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentarios
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-10-16 17:21:07 CST

--
-- PostgreSQL database dump complete
--

