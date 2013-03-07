--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO dwiedenbruch;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.teams OWNER TO dwiedenbruch;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO dwiedenbruch;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('teams_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY schema_migrations (version) FROM stdin;
20130304145903
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY teams (id, name, created_at, updated_at) FROM stdin;
1	FC Bayern München	2013-03-06 08:27:35.497483	2013-03-06 08:27:35.497483
\.


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: dwiedenbruch
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM dwiedenbruch;
GRANT ALL ON SCHEMA public TO dwiedenbruch;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

