--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-2.pgdg90+1)
-- Dumped by pg_dump version 10.5 (Debian 10.5-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
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
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- Name: evento_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_categoria (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.evento_categoria OWNER TO postgres;

--
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
-- Name: evento_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_categoria_id_seq OWNED BY public.evento_categoria.id;


--
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
-- Name: evento_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_comentario_id_seq OWNED BY public.evento_comentario.id;


--
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
-- Name: evento_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_data_id_seq OWNED BY public.evento_data.id;


--
-- Name: evento_fotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_fotos (
    id integer NOT NULL,
    id_evento integer NOT NULL,
    path_foto text NOT NULL
);


ALTER TABLE public.evento_fotos OWNER TO postgres;

--
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
-- Name: evento_fotos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evento_fotos_id_seq OWNED BY public.evento_fotos.id;


--
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
-- Name: user_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_data_id_seq OWNED BY public.user_data.id;


--
-- Name: usuario_evento_creado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_creado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_creado OWNER TO postgres;

--
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
-- Name: usuario_evento_creado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_evento_creado_id_seq OWNED BY public.usuario_evento_creado.id;


--
-- Name: usuario_evento_registrado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_evento_registrado (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.usuario_evento_registrado OWNER TO postgres;

--
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- Name: evento_categoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria ALTER COLUMN id SET DEFAULT nextval('public.evento_categoria_id_seq'::regclass);


--
-- Name: evento_comentario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario ALTER COLUMN id SET DEFAULT nextval('public.evento_comentario_id_seq'::regclass);


--
-- Name: evento_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data ALTER COLUMN id SET DEFAULT nextval('public.evento_data_id_seq'::regclass);


--
-- Name: evento_fotos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos ALTER COLUMN id SET DEFAULT nextval('public.evento_fotos_id_seq'::regclass);


--
-- Name: user_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data ALTER COLUMN id SET DEFAULT nextval('public.user_data_id_seq'::regclass);


--
-- Name: usuario_evento_creado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado ALTER COLUMN id SET DEFAULT nextval('public.usuario_evento_creado_id_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id, nombre) FROM stdin;
1	Deporte
2	Arte
3	Senderismo
4	Cocina
5	Recreativo
\.


--
-- Data for Name: evento_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_categoria (id, id_evento, id_categoria) FROM stdin;
\.


--
-- Data for Name: evento_comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_comentario (id, id_evento, id_user, comentario) FROM stdin;
\.


--
-- Data for Name: evento_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_data (id, nombre, description, fecha, hora, precio, path_foto_p) FROM stdin;
\.


--
-- Data for Name: evento_fotos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_fotos (id, id_evento, path_foto) FROM stdin;
\.


--
-- Data for Name: user_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_data (id, correo, contrasena, nombre_usuario, pais, path_foto) FROM stdin;
\.


--
-- Data for Name: usuario_evento_creado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_evento_creado (id, id_user, id_evento) FROM stdin;
\.


--
-- Data for Name: usuario_evento_registrado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_evento_registrado (id, id_user, id_evento) FROM stdin;
\.


--
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_seq', 1, false);


--
-- Name: evento_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_categoria_id_seq', 1, false);


--
-- Name: evento_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_comentario_id_seq', 1, false);


--
-- Name: evento_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_data_id_seq', 1, false);


--
-- Name: evento_fotos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evento_fotos_id_seq', 1, false);


--
-- Name: user_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_data_id_seq', 1, false);


--
-- Name: usuario_evento_creado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_evento_creado_id_seq', 1, false);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- Name: evento_categoria evento_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_pkey PRIMARY KEY (id_evento);


--
-- Name: evento_comentario evento_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT evento_comentario_pkey PRIMARY KEY (id_evento);


--
-- Name: evento_data evento_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_data
    ADD CONSTRAINT evento_data_pkey PRIMARY KEY (id);


--
-- Name: evento_fotos evento_fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT evento_fotos_pkey PRIMARY KEY (id_evento);


--
-- Name: user_data user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (id);


--
-- Name: usuario_evento_creado usuario_evento_creado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT usuario_evento_creado_pkey PRIMARY KEY (id_user);


--
-- Name: usuario_evento_registrado usuario_evento_registrado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT usuario_evento_registrado_pkey PRIMARY KEY (id_user);


--
-- Name: evento_categoria fk_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id);


--
-- Name: usuario_evento_creado fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- Name: evento_categoria fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- Name: evento_comentario fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- Name: evento_fotos fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_fotos
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- Name: usuario_evento_registrado fk_evento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES public.evento_data(id);


--
-- Name: usuario_evento_creado fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_creado
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- Name: evento_comentario fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_comentario
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- Name: usuario_evento_registrado fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_evento_registrado
    ADD CONSTRAINT fk_user FOREIGN KEY (id_user) REFERENCES public.user_data(id);


--
-- PostgreSQL database dump complete
--

