--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.2

-- Started on 2023-10-02 18:34:18 CST

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

SET default_tablespace = '';


--
-- TOC entry 219 (class 1259 OID 16561)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16560)
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
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 218
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 223 (class 1259 OID 16587)
-- Name: evento_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_categoria (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.evento_categoria OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16586)
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
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 222
-- Name: evento_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_categoria_id_seq OWNED BY public.evento_categoria.id;


--
-- TOC entry 225 (class 1259 OID 16604)
-- Name: evento_comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_comentario (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    id_user integer NOT NULL,
    comentario text NOT NULL
);


ALTER TABLE public.evento_comentario OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16603)
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
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 224
-- Name: evento_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_comentario_id_seq OWNED BY public.evento_comentario.id;


--
-- TOC entry 217 (class 1259 OID 16552)
-- Name: evento_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_data (
    id integer NOT NULL,
    nombre text NOT NULL,
    description text NOT NULL,
    fecha date NOT NULL,
    hora text NOT NULL,
    precio numeric NOT NULL,
    path_foto_p text NOT NULL
);


ALTER TABLE public.evento_data OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16551)
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
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 216
-- Name: evento_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_data_id_seq OWNED BY public.evento_data.id;


--
-- TOC entry 227 (class 1259 OID 16623)
-- Name: evento_fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_fotos (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    path_foto text NOT NULL
);


ALTER TABLE public.evento_fotos OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16622)
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
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 226
-- Name: evento_fotos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_fotos_id_seq OWNED BY public.evento_fotos.id;


--
-- TOC entry 215 (class 1259 OID 16543)
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
-- TOC entry 214 (class 1259 OID 16542)
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
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 214
-- Name: user_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_data_id_seq OWNED BY public.user_data.id;


--
-- TOC entry 221 (class 1259 OID 16570)
-- Name: usuario_evento_creado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_creado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_creado OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16569)
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
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 220
-- Name: usuario_evento_creado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_evento_creado_id_seq OWNED BY public.usuario_evento_creado.id;


--
-- TOC entry 228 (class 1259 OID 16636)
-- Name: usuario_evento_registrado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_registrado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_registrado OWNER TO postgres;

--
-- TOC entry 3497 (class 2604 OID 16564)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 3499 (class 2604 OID 16590)
-- Name: evento_categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria ALTER COLUMN id SET DEFAULT nextval('public.evento_categoria_id_seq'::regclass);


--
-- TOC entry 3500 (class 2604 OID 16607)
-- Name: evento_comentario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario ALTER COLUMN id SET DEFAULT nextval('public.evento_comentario_id_seq'::regclass);


--
-- TOC entry 3496 (class 2604 OID 16555)
-- Name: evento_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data ALTER COLUMN id SET DEFAULT nextval('public.evento_data_id_seq'::regclass);


--
-- TOC entry 3501 (class 2604 OID 16626)
-- Name: evento_fotos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos ALTER COLUMN id SET DEFAULT nextval('public.evento_fotos_id_seq'::regclass);


--
-- TOC entry 3495 (class 2604 OID 16546)
-- Name: user_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data ALTER COLUMN id SET DEFAULT nextval('public.user_data_id_seq'::regclass);


--
-- TOC entry 3498 (class 2604 OID 16573)
-- Name: usuario_evento_creado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado ALTER COLUMN id SET DEFAULT nextval('public.usuario_evento_creado_id_seq'::regclass);


--
-- TOC entry 3507 (class 2606 OID 16568)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 3511 (class 2606 OID 16592)
-- Name: evento_categoria evento_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 3513 (class 2606 OID 16611)
-- Name: evento_comentario evento_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT evento_comentario_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 3505 (class 2606 OID 16559)
-- Name: evento_data evento_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data
    ADD CONSTRAINT evento_data_pkey PRIMARY KEY (id);


--
-- TOC entry 3515 (class 2606 OID 16630)
-- Name: evento_fotos evento_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT evento_fotos_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 3503 (class 2606 OID 16550)
-- Name: user_data user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (id);


--
-- TOC entry 3509 (class 2606 OID 16575)
-- Name: usuario_evento_creado usuario_evento_creado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT usuario_evento_creado_pkey PRIMARY KEY (id_user);


--
-- TOC entry 3517 (class 2606 OID 16640)
-- Name: usuario_evento_registrado usuario_evento_registrado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT usuario_evento_registrado_pkey PRIMARY KEY (id_user);


--
-- TOC entry 3520 (class 2606 OID 16598)
-- Name: evento_categoria fk_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id);


--
-- TOC entry 3518 (class 2606 OID 16581)
-- Name: usuario_evento_creado fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 3521 (class 2606 OID 16593)
-- Name: evento_categoria fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 3522 (class 2606 OID 16612)
-- Name: evento_comentario fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 3524 (class 2606 OID 16631)
-- Name: evento_fotos fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 3525 (class 2606 OID 16646)
-- Name: usuario_evento_registrado fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- TOC entry 3519 (class 2606 OID 16576)
-- Name: usuario_evento_creado fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- TOC entry 3523 (class 2606 OID 16617)
-- Name: evento_comentario fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- TOC entry 3526 (class 2606 OID 16641)
-- Name: usuario_evento_registrado fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


-- Completed on 2023-10-02 18:34:19 CST

--
-- PostgreSQL database dump complete
--

