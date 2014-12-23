--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: appointments; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE appointments (
    id integer NOT NULL,
    appointable_id integer NOT NULL,
    appointable_type character varying(255) NOT NULL,
    competition_id integer,
    appointed_at timestamp without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO dwiedenbruch;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointments_id_seq OWNER TO dwiedenbruch;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE appointments_id_seq OWNED BY appointments.id;


--
-- Name: competitions; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE competitions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    level integer,
    federation_id integer,
    season_id integer,
    start timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.competitions OWNER TO dwiedenbruch;

--
-- Name: competitions_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE competitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.competitions_id_seq OWNER TO dwiedenbruch;

--
-- Name: competitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE competitions_id_seq OWNED BY competitions.id;


--
-- Name: competitions_teams; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE competitions_teams (
    id integer NOT NULL,
    competition_id integer,
    team_id integer
);


ALTER TABLE public.competitions_teams OWNER TO dwiedenbruch;

--
-- Name: competitions_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE competitions_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.competitions_teams_id_seq OWNER TO dwiedenbruch;

--
-- Name: competitions_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE competitions_teams_id_seq OWNED BY competitions_teams.id;


--
-- Name: draws; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE draws (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    performed_at timestamp without time zone,
    finished boolean DEFAULT false,
    cup_id integer,
    matchday_id integer
);


ALTER TABLE public.draws OWNER TO dwiedenbruch;

--
-- Name: draws_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE draws_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.draws_id_seq OWNER TO dwiedenbruch;

--
-- Name: draws_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE draws_id_seq OWNED BY draws.id;


--
-- Name: federations; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE federations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.federations OWNER TO dwiedenbruch;

--
-- Name: federations_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE federations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.federations_id_seq OWNER TO dwiedenbruch;

--
-- Name: federations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE federations_id_seq OWNED BY federations.id;


--
-- Name: federations_seasons; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE federations_seasons (
    federation_id integer,
    season_id integer
);


ALTER TABLE public.federations_seasons OWNER TO dwiedenbruch;

--
-- Name: games; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE games (
    id integer NOT NULL,
    home_id integer NOT NULL,
    guest_id integer NOT NULL,
    home_goals integer,
    guest_goals integer,
    home_half_goals integer,
    guest_half_goals integer,
    home_full_goals integer,
    guest_full_goals integer,
    home_xtra_half_goals integer,
    guest_xtra_half_goals integer,
    home_xtra_full_goals integer,
    guest_xtra_full_goals integer,
    half_second integer,
    full_second integer,
    xtra_half_second integer,
    xtra_full_second integer,
    second integer DEFAULT 0,
    level integer,
    performed_at timestamp without time zone,
    decision boolean DEFAULT false,
    finished boolean DEFAULT false,
    matchday_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.games OWNER TO dwiedenbruch;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO dwiedenbruch;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: matchdays; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE matchdays (
    id integer NOT NULL,
    number integer NOT NULL,
    start timestamp without time zone NOT NULL,
    competition_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.matchdays OWNER TO dwiedenbruch;

--
-- Name: matchdays_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE matchdays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matchdays_id_seq OWNER TO dwiedenbruch;

--
-- Name: matchdays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE matchdays_id_seq OWNED BY matchdays.id;


--
-- Name: points; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE points (
    id integer NOT NULL,
    points integer,
    goals integer,
    against integer,
    diff integer,
    win integer,
    draw integer,
    lost integer,
    level integer,
    game_id integer NOT NULL,
    team_id integer NOT NULL,
    league_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.points OWNER TO dwiedenbruch;

--
-- Name: points_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.points_id_seq OWNER TO dwiedenbruch;

--
-- Name: points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE points_id_seq OWNED BY points.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    points integer DEFAULT 0,
    goals integer DEFAULT 0,
    against integer DEFAULT 0,
    diff integer DEFAULT 0,
    win integer DEFAULT 0,
    draw integer DEFAULT 0,
    lost integer DEFAULT 0,
    team_id integer NOT NULL,
    league_id integer NOT NULL,
    level integer,
    year integer,
    rank integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.results OWNER TO dwiedenbruch;

--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO dwiedenbruch;

--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO dwiedenbruch;

--
-- Name: seasons; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE seasons (
    id integer NOT NULL,
    year integer NOT NULL,
    start timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.seasons OWNER TO dwiedenbruch;

--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: dwiedenbruch
--

CREATE SEQUENCE seasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seasons_id_seq OWNER TO dwiedenbruch;

--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dwiedenbruch
--

ALTER SEQUENCE seasons_id_seq OWNED BY seasons.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    short_name character varying(255) NOT NULL,
    abbreviation character varying(255) NOT NULL,
    federation_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY appointments ALTER COLUMN id SET DEFAULT nextval('appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY competitions ALTER COLUMN id SET DEFAULT nextval('competitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY competitions_teams ALTER COLUMN id SET DEFAULT nextval('competitions_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY draws ALTER COLUMN id SET DEFAULT nextval('draws_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY federations ALTER COLUMN id SET DEFAULT nextval('federations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY matchdays ALTER COLUMN id SET DEFAULT nextval('matchdays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY points ALTER COLUMN id SET DEFAULT nextval('points_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY seasons ALTER COLUMN id SET DEFAULT nextval('seasons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dwiedenbruch
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY appointments (id, appointable_id, appointable_type, competition_id, appointed_at) FROM stdin;
1	1	Game	1	2009-08-29 15:30:00
2	2	Game	1	2009-08-29 15:30:00
3	3	Game	1	2009-08-29 15:30:00
4	4	Game	1	2009-08-29 15:30:00
5	5	Game	1	2009-08-29 15:30:00
6	6	Game	1	2009-08-29 15:30:00
7	7	Game	1	2009-08-29 15:30:00
8	8	Game	1	2009-08-29 15:30:00
9	9	Game	1	2009-08-29 15:30:00
10	10	Game	1	2009-08-29 15:30:00
11	11	Game	1	2009-08-29 15:30:00
12	12	Game	1	2009-08-29 15:30:00
13	13	Game	1	2009-08-29 15:30:00
14	14	Game	1	2009-08-29 15:30:00
15	15	Game	1	2009-08-29 15:30:00
16	16	Game	1	2009-08-29 15:30:00
17	17	Game	1	2009-08-29 15:30:00
18	18	Game	1	2009-08-29 15:30:00
19	19	Game	1	2009-08-29 15:30:00
20	20	Game	1	2009-08-29 15:30:00
21	21	Game	1	2009-08-29 15:30:00
22	22	Game	1	2009-08-29 15:30:00
23	23	Game	1	2009-08-29 15:30:00
24	24	Game	1	2009-08-29 15:30:00
25	25	Game	1	2009-08-29 15:30:00
26	26	Game	1	2009-08-29 15:30:00
27	27	Game	1	2009-08-29 15:30:00
28	28	Game	1	2009-08-29 15:30:00
29	29	Game	1	2009-08-29 15:30:00
30	30	Game	1	2009-08-29 15:30:00
31	31	Game	1	2009-08-29 15:30:00
32	32	Game	1	2009-08-29 15:30:00
33	33	Game	2	2009-10-28 20:30:00
34	34	Game	2	2009-10-28 20:30:00
35	35	Game	2	2009-10-28 20:30:00
36	36	Game	2	2009-10-28 20:30:00
37	37	Game	2	2009-10-28 20:30:00
38	38	Game	2	2009-10-28 20:30:00
39	39	Game	2	2009-10-28 20:30:00
40	40	Game	2	2009-10-28 20:30:00
41	41	Game	2	2009-10-28 20:30:00
42	42	Game	2	2009-10-28 20:30:00
43	43	Game	2	2009-10-28 20:30:00
44	44	Game	2	2009-10-28 20:30:00
45	45	Game	2	2009-10-28 20:30:00
46	46	Game	2	2009-10-28 20:30:00
47	47	Game	2	2009-10-28 20:30:00
48	48	Game	2	2009-10-28 20:30:00
49	49	Game	2	2009-12-16 20:30:00
50	50	Game	2	2009-12-16 20:30:00
51	51	Game	2	2009-12-16 20:30:00
52	52	Game	2	2009-12-16 20:30:00
53	53	Game	2	2009-12-16 20:30:00
54	54	Game	2	2009-12-16 20:30:00
55	55	Game	2	2009-12-16 20:30:00
56	56	Game	2	2009-12-16 20:30:00
57	57	Game	1	2010-03-03 20:30:00
58	58	Game	1	2010-03-03 20:30:00
59	59	Game	1	2010-03-03 20:30:00
60	60	Game	1	2010-03-03 20:30:00
61	61	Game	2	2010-04-14 20:30:00
62	62	Game	2	2010-04-14 20:30:00
63	63	Game	1	2010-05-22 15:30:00
64	64	Game	2	2009-08-08 15:30:00
65	65	Game	2	2009-08-08 15:30:00
66	66	Game	2	2009-08-08 15:30:00
67	67	Game	2	2009-08-08 15:30:00
68	68	Game	2	2009-08-08 15:30:00
69	69	Game	2	2009-08-08 15:30:00
70	70	Game	2	2009-08-08 15:30:00
71	71	Game	2	2009-08-08 15:30:00
72	72	Game	2	2009-08-08 15:30:00
73	73	Game	1	2009-08-15 15:30:00
74	74	Game	1	2009-08-15 15:30:00
75	75	Game	1	2009-08-15 15:30:00
76	76	Game	1	2009-08-15 15:30:00
77	77	Game	1	2009-08-15 15:30:00
78	78	Game	1	2009-08-15 15:30:00
79	79	Game	1	2009-08-15 15:30:00
80	80	Game	1	2009-08-15 15:30:00
81	81	Game	1	2009-08-15 15:30:00
82	82	Game	2	2009-08-22 15:30:00
83	83	Game	2	2009-08-22 15:30:00
84	84	Game	2	2009-08-22 15:30:00
85	85	Game	2	2009-08-22 15:30:00
86	86	Game	2	2009-08-22 15:30:00
87	87	Game	2	2009-08-22 15:30:00
88	88	Game	2	2009-08-22 15:30:00
89	89	Game	2	2009-08-22 15:30:00
90	90	Game	2	2009-08-22 15:30:00
91	91	Game	1	2009-09-13 20:30:00
92	92	Game	1	2009-09-13 20:30:00
93	93	Game	1	2009-09-13 20:30:00
94	94	Game	1	2009-09-13 20:30:00
95	95	Game	1	2009-09-13 20:30:00
96	96	Game	1	2009-09-13 20:30:00
97	97	Game	1	2009-09-13 20:30:00
98	98	Game	1	2009-09-13 20:30:00
99	99	Game	1	2009-09-13 20:30:00
100	100	Game	1	2009-09-16 20:30:00
101	101	Game	1	2009-09-16 20:30:00
102	102	Game	1	2009-09-16 20:30:00
103	103	Game	1	2009-09-16 20:30:00
104	104	Game	1	2009-09-16 20:30:00
105	105	Game	1	2009-09-16 20:30:00
106	106	Game	1	2009-09-16 20:30:00
107	107	Game	1	2009-09-16 20:30:00
108	108	Game	1	2009-09-16 20:30:00
109	109	Game	2	2009-09-23 20:30:00
110	110	Game	2	2009-09-23 20:30:00
111	111	Game	2	2009-09-23 20:30:00
112	112	Game	2	2009-09-23 20:30:00
113	113	Game	2	2009-09-23 20:30:00
114	114	Game	2	2009-09-23 20:30:00
115	115	Game	2	2009-09-23 20:30:00
116	116	Game	2	2009-09-23 20:30:00
117	117	Game	2	2009-09-23 20:30:00
118	118	Game	2	2009-09-30 20:30:00
119	119	Game	2	2009-09-30 20:30:00
120	120	Game	2	2009-09-30 20:30:00
121	121	Game	2	2009-09-30 20:30:00
122	122	Game	2	2009-09-30 20:30:00
123	123	Game	2	2009-09-30 20:30:00
124	124	Game	2	2009-09-30 20:30:00
125	125	Game	2	2009-09-30 20:30:00
126	126	Game	2	2009-09-30 20:30:00
127	127	Game	2	2009-10-14 20:30:00
128	128	Game	2	2009-10-14 20:30:00
129	129	Game	2	2009-10-14 20:30:00
130	130	Game	2	2009-10-14 20:30:00
131	131	Game	2	2009-10-14 20:30:00
132	132	Game	2	2009-10-14 20:30:00
133	133	Game	2	2009-10-14 20:30:00
134	134	Game	2	2009-10-14 20:30:00
135	135	Game	2	2009-10-14 20:30:00
136	136	Game	2	2009-10-21 20:30:00
137	137	Game	2	2009-10-21 20:30:00
138	138	Game	2	2009-10-21 20:30:00
139	139	Game	2	2009-10-21 20:30:00
140	140	Game	2	2009-10-21 20:30:00
141	141	Game	2	2009-10-21 20:30:00
142	142	Game	2	2009-10-21 20:30:00
143	143	Game	2	2009-10-21 20:30:00
144	144	Game	2	2009-10-21 20:30:00
145	145	Game	2	2009-10-28 20:30:00
146	146	Game	2	2009-10-28 20:30:00
147	147	Game	2	2009-10-28 20:30:00
148	148	Game	2	2009-10-28 20:30:00
149	149	Game	2	2009-10-28 20:30:00
150	150	Game	2	2009-10-28 20:30:00
151	151	Game	2	2009-10-28 20:30:00
152	152	Game	2	2009-10-28 20:30:00
153	153	Game	2	2009-10-28 20:30:00
154	154	Game	2	2009-11-04 20:30:00
155	155	Game	2	2009-11-04 20:30:00
156	156	Game	2	2009-11-04 20:30:00
157	157	Game	2	2009-11-04 20:30:00
158	158	Game	2	2009-11-04 20:30:00
159	159	Game	2	2009-11-04 20:30:00
160	160	Game	2	2009-11-04 20:30:00
161	161	Game	2	2009-11-04 20:30:00
162	162	Game	2	2009-11-04 20:30:00
163	163	Game	2	2009-11-11 20:30:00
164	164	Game	2	2009-11-11 20:30:00
165	165	Game	2	2009-11-11 20:30:00
166	166	Game	2	2009-11-11 20:30:00
167	167	Game	2	2009-11-11 20:30:00
168	168	Game	2	2009-11-11 20:30:00
169	169	Game	2	2009-11-11 20:30:00
170	170	Game	2	2009-11-11 20:30:00
171	171	Game	2	2009-11-11 20:30:00
172	172	Game	2	2009-11-25 20:30:00
173	173	Game	2	2009-11-25 20:30:00
174	174	Game	2	2009-11-25 20:30:00
175	175	Game	2	2009-11-25 20:30:00
176	176	Game	2	2009-11-25 20:30:00
177	177	Game	2	2009-11-25 20:30:00
178	178	Game	2	2009-11-25 20:30:00
179	179	Game	2	2009-11-25 20:30:00
180	180	Game	2	2009-11-25 20:30:00
181	181	Game	2	2009-12-02 20:30:00
182	182	Game	2	2009-12-02 20:30:00
183	183	Game	2	2009-12-02 20:30:00
184	184	Game	2	2009-12-02 20:30:00
185	185	Game	2	2009-12-02 20:30:00
186	186	Game	2	2009-12-02 20:30:00
187	187	Game	2	2009-12-02 20:30:00
188	188	Game	2	2009-12-02 20:30:00
189	189	Game	2	2009-12-02 20:30:00
190	190	Game	2	2009-12-09 20:30:00
191	191	Game	2	2009-12-09 20:30:00
192	192	Game	2	2009-12-09 20:30:00
193	193	Game	2	2009-12-09 20:30:00
194	194	Game	2	2009-12-09 20:30:00
195	195	Game	2	2009-12-09 20:30:00
196	196	Game	2	2009-12-09 20:30:00
197	197	Game	2	2009-12-09 20:30:00
198	198	Game	2	2009-12-09 20:30:00
199	199	Game	2	2009-12-16 20:30:00
200	200	Game	2	2009-12-16 20:30:00
201	201	Game	2	2009-12-16 20:30:00
202	202	Game	2	2009-12-16 20:30:00
203	203	Game	2	2009-12-16 20:30:00
204	204	Game	2	2009-12-16 20:30:00
205	205	Game	2	2009-12-16 20:30:00
206	206	Game	2	2009-12-16 20:30:00
207	207	Game	2	2009-12-16 20:30:00
208	208	Game	2	2009-12-23 20:30:00
209	209	Game	2	2009-12-23 20:30:00
210	210	Game	2	2009-12-23 20:30:00
211	211	Game	2	2009-12-23 20:30:00
212	212	Game	2	2009-12-23 20:30:00
213	213	Game	2	2009-12-23 20:30:00
214	214	Game	2	2009-12-23 20:30:00
215	215	Game	2	2009-12-23 20:30:00
216	216	Game	2	2009-12-23 20:30:00
217	217	Game	2	2010-01-27 20:30:00
218	218	Game	2	2010-01-27 20:30:00
219	219	Game	2	2010-01-27 20:30:00
220	220	Game	2	2010-01-27 20:30:00
221	221	Game	2	2010-01-27 20:30:00
222	222	Game	2	2010-01-27 20:30:00
223	223	Game	2	2010-01-27 20:30:00
224	224	Game	2	2010-01-27 20:30:00
225	225	Game	2	2010-01-27 20:30:00
226	226	Game	2	2010-02-03 20:30:00
227	227	Game	2	2010-02-03 20:30:00
228	228	Game	2	2010-02-03 20:30:00
229	229	Game	2	2010-02-03 20:30:00
230	230	Game	2	2010-02-03 20:30:00
231	231	Game	2	2010-02-03 20:30:00
232	232	Game	2	2010-02-03 20:30:00
233	233	Game	2	2010-02-03 20:30:00
234	234	Game	2	2010-02-03 20:30:00
235	235	Game	2	2010-02-07 20:30:00
236	236	Game	2	2010-02-07 20:30:00
237	237	Game	2	2010-02-07 20:30:00
238	238	Game	2	2010-02-07 20:30:00
239	239	Game	2	2010-02-07 20:30:00
240	240	Game	2	2010-02-07 20:30:00
241	241	Game	2	2010-02-07 20:30:00
242	242	Game	2	2010-02-07 20:30:00
243	243	Game	2	2010-02-07 20:30:00
244	244	Game	2	2010-02-10 20:30:00
245	245	Game	2	2010-02-10 20:30:00
246	246	Game	2	2010-02-10 20:30:00
247	247	Game	2	2010-02-10 20:30:00
248	248	Game	2	2010-02-10 20:30:00
249	249	Game	2	2010-02-10 20:30:00
250	250	Game	2	2010-02-10 20:30:00
251	251	Game	2	2010-02-10 20:30:00
252	252	Game	2	2010-02-10 20:30:00
253	253	Game	2	2010-02-17 20:30:00
254	254	Game	2	2010-02-17 20:30:00
255	255	Game	2	2010-02-17 20:30:00
256	256	Game	2	2010-02-17 20:30:00
257	257	Game	2	2010-02-17 20:30:00
258	258	Game	2	2010-02-17 20:30:00
259	259	Game	2	2010-02-17 20:30:00
260	260	Game	2	2010-02-17 20:30:00
261	261	Game	2	2010-02-17 20:30:00
262	262	Game	2	2010-02-24 20:30:00
263	263	Game	2	2010-02-24 20:30:00
264	264	Game	2	2010-02-24 20:30:00
265	265	Game	2	2010-02-24 20:30:00
266	266	Game	2	2010-02-24 20:30:00
267	267	Game	2	2010-02-24 20:30:00
268	268	Game	2	2010-02-24 20:30:00
269	269	Game	2	2010-02-24 20:30:00
270	270	Game	2	2010-02-24 20:30:00
271	271	Game	2	2010-03-03 20:30:00
272	272	Game	2	2010-03-03 20:30:00
273	273	Game	2	2010-03-03 20:30:00
274	274	Game	2	2010-03-03 20:30:00
275	275	Game	2	2010-03-03 20:30:00
276	276	Game	2	2010-03-03 20:30:00
277	277	Game	2	2010-03-03 20:30:00
278	278	Game	2	2010-03-03 20:30:00
279	279	Game	2	2010-03-03 20:30:00
280	280	Game	2	2010-03-10 20:30:00
281	281	Game	2	2010-03-10 20:30:00
282	282	Game	2	2010-03-10 20:30:00
283	283	Game	2	2010-03-10 20:30:00
284	284	Game	2	2010-03-10 20:30:00
285	285	Game	2	2010-03-10 20:30:00
286	286	Game	2	2010-03-10 20:30:00
287	287	Game	2	2010-03-10 20:30:00
288	288	Game	2	2010-03-10 20:30:00
289	289	Game	2	2010-03-17 20:30:00
290	290	Game	2	2010-03-17 20:30:00
291	291	Game	2	2010-03-17 20:30:00
292	292	Game	2	2010-03-17 20:30:00
293	293	Game	2	2010-03-17 20:30:00
294	294	Game	2	2010-03-17 20:30:00
295	295	Game	2	2010-03-17 20:30:00
296	296	Game	2	2010-03-17 20:30:00
297	297	Game	2	2010-03-17 20:30:00
298	298	Game	2	2010-03-24 20:30:00
299	299	Game	2	2010-03-24 20:30:00
300	300	Game	2	2010-03-24 20:30:00
301	301	Game	2	2010-03-24 20:30:00
302	302	Game	2	2010-03-24 20:30:00
303	303	Game	2	2010-03-24 20:30:00
304	304	Game	2	2010-03-24 20:30:00
305	305	Game	2	2010-03-24 20:30:00
306	306	Game	2	2010-03-24 20:30:00
307	307	Game	2	2010-04-07 20:30:00
308	308	Game	2	2010-04-07 20:30:00
309	309	Game	2	2010-04-07 20:30:00
310	310	Game	2	2010-04-07 20:30:00
311	311	Game	2	2010-04-07 20:30:00
312	312	Game	2	2010-04-07 20:30:00
313	313	Game	2	2010-04-07 20:30:00
314	314	Game	2	2010-04-07 20:30:00
315	315	Game	2	2010-04-07 20:30:00
316	316	Game	2	2010-04-14 20:30:00
317	317	Game	2	2010-04-14 20:30:00
318	318	Game	2	2010-04-14 20:30:00
319	319	Game	2	2010-04-14 20:30:00
320	320	Game	2	2010-04-14 20:30:00
321	321	Game	2	2010-04-14 20:30:00
322	322	Game	2	2010-04-14 20:30:00
323	323	Game	2	2010-04-14 20:30:00
324	324	Game	2	2010-04-14 20:30:00
325	325	Game	2	2010-04-21 20:30:00
326	326	Game	2	2010-04-21 20:30:00
327	327	Game	2	2010-04-21 20:30:00
328	328	Game	2	2010-04-21 20:30:00
329	329	Game	2	2010-04-21 20:30:00
330	330	Game	2	2010-04-21 20:30:00
331	331	Game	2	2010-04-21 20:30:00
332	332	Game	2	2010-04-21 20:30:00
333	333	Game	2	2010-04-21 20:30:00
334	334	Game	2	2010-04-28 20:30:00
335	335	Game	2	2010-04-28 20:30:00
336	336	Game	2	2010-04-28 20:30:00
337	337	Game	2	2010-04-28 20:30:00
338	338	Game	2	2010-04-28 20:30:00
339	339	Game	2	2010-04-28 20:30:00
340	340	Game	2	2010-04-28 20:30:00
341	341	Game	2	2010-04-28 20:30:00
342	342	Game	2	2010-04-28 20:30:00
343	343	Game	2	2010-05-05 20:30:00
344	344	Game	2	2010-05-05 20:30:00
345	345	Game	2	2010-05-05 20:30:00
346	346	Game	2	2010-05-05 20:30:00
347	347	Game	2	2010-05-05 20:30:00
348	348	Game	2	2010-05-05 20:30:00
349	349	Game	2	2010-05-05 20:30:00
350	350	Game	2	2010-05-05 20:30:00
351	351	Game	2	2010-05-05 20:30:00
352	352	Game	2	2010-05-12 20:30:00
353	353	Game	2	2010-05-12 20:30:00
354	354	Game	2	2010-05-12 20:30:00
355	355	Game	2	2010-05-12 20:30:00
356	356	Game	2	2010-05-12 20:30:00
357	357	Game	2	2010-05-12 20:30:00
358	358	Game	2	2010-05-12 20:30:00
359	359	Game	2	2010-05-12 20:30:00
360	360	Game	2	2010-05-12 20:30:00
361	361	Game	2	2010-05-19 20:30:00
362	362	Game	2	2010-05-19 20:30:00
363	363	Game	2	2010-05-19 20:30:00
364	364	Game	2	2010-05-19 20:30:00
365	365	Game	2	2010-05-19 20:30:00
366	366	Game	2	2010-05-19 20:30:00
367	367	Game	2	2010-05-19 20:30:00
368	368	Game	2	2010-05-19 20:30:00
369	369	Game	2	2010-05-19 20:30:00
\.


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('appointments_id_seq', 369, true);


--
-- Data for Name: competitions; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY competitions (id, name, type, level, federation_id, season_id, start, created_at, updated_at) FROM stdin;
1	DFB Pokal	Cup	1	1	1	2009-08-08 15:30:00	2014-12-22 13:21:12.287	2014-12-22 13:21:12.351
2	Bundesliga	League	1	1	1	2009-08-08 15:30:00	2014-12-22 13:21:14.62	2014-12-22 13:21:14.675
3	2.Bundesliga	League	2	1	1	2009-08-08 15:30:00	2014-12-22 13:21:29.444	2014-12-22 13:21:29.444
4	3.Bundesliga	League	3	1	1	2009-08-08 15:30:00	2014-12-22 13:21:29.654	2014-12-22 13:21:29.654
5	4.Bundesliga	League	4	1	1	2009-08-08 15:30:00	2014-12-22 13:21:29.923	2014-12-22 13:21:29.923
6	5.Bundesliga	League	5	1	1	2009-08-08 15:30:00	2014-12-22 13:21:30.198	2014-12-22 13:21:30.198
7	6.Bundesliga A	League	6	1	1	2009-08-08 15:30:00	2014-12-22 13:21:30.431	2014-12-22 13:21:30.431
8	6.Bundesliga B	League	6	1	1	2009-08-08 15:30:00	2014-12-22 13:21:30.702	2014-12-22 13:21:30.702
\.


--
-- Name: competitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('competitions_id_seq', 8, true);


--
-- Data for Name: competitions_teams; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY competitions_teams (id, competition_id, team_id) FROM stdin;
1	2	1
2	2	2
3	2	3
4	2	4
5	2	5
6	2	6
7	2	7
8	2	8
9	2	9
10	2	10
11	2	11
12	2	12
13	2	13
14	2	14
15	2	15
16	2	19
17	2	20
18	2	21
19	3	16
20	3	17
21	3	18
22	3	22
23	3	23
24	3	24
25	3	25
26	3	26
27	3	27
28	3	28
29	3	29
30	3	30
31	3	31
32	3	32
33	3	33
34	3	37
35	3	38
36	3	39
37	4	34
38	4	35
39	4	36
40	4	40
41	4	41
42	4	42
43	4	43
44	4	44
45	4	45
46	4	46
47	4	47
48	4	48
49	4	49
50	4	50
51	4	51
52	4	52
53	4	53
54	4	55
55	5	54
56	5	56
57	5	57
58	5	58
59	5	59
60	5	67
61	5	87
62	5	60
63	5	65
64	5	61
65	5	66
66	5	62
67	5	64
68	5	68
69	5	69
70	5	71
71	5	63
72	5	70
73	6	72
74	6	73
75	6	74
76	6	75
77	6	76
78	6	77
79	6	78
80	6	79
81	6	80
82	6	81
83	6	82
84	6	83
85	6	84
86	6	85
87	6	86
88	6	88
89	6	89
90	6	90
91	7	91
92	7	92
93	7	93
94	7	94
95	7	95
96	7	96
97	7	97
98	7	98
99	7	99
100	7	100
101	7	101
102	7	102
103	7	103
104	7	104
105	7	105
106	7	106
107	7	107
108	7	108
109	8	109
110	8	110
111	8	111
112	8	112
113	8	113
114	8	114
115	8	115
116	8	116
117	8	117
118	8	118
119	8	119
120	8	120
121	8	121
122	8	122
123	8	123
124	8	124
125	8	125
126	8	126
\.


--
-- Name: competitions_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('competitions_teams_id_seq', 126, true);


--
-- Data for Name: draws; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY draws (id, name, performed_at, finished, cup_id, matchday_id) FROM stdin;
\.


--
-- Name: draws_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('draws_id_seq', 1, false);


--
-- Data for Name: federations; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY federations (id, name, created_at, updated_at) FROM stdin;
1	DFB	2014-12-16 08:06:54.264	2014-12-16 08:06:54.264
\.


--
-- Name: federations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('federations_id_seq', 1, true);


--
-- Data for Name: federations_seasons; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY federations_seasons (federation_id, season_id) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY games (id, home_id, guest_id, home_goals, guest_goals, home_half_goals, guest_half_goals, home_full_goals, guest_full_goals, home_xtra_half_goals, guest_xtra_half_goals, home_xtra_full_goals, guest_xtra_full_goals, half_second, full_second, xtra_half_second, xtra_full_second, second, level, performed_at, decision, finished, matchday_id, created_at, updated_at) FROM stdin;
1	36	10	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.589	2014-12-22 13:21:12.616
2	44	20	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.696	2014-12-22 13:21:12.706
3	53	11	1	2	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.724	2014-12-22 13:21:12.739
4	58	13	0	6	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.758	2014-12-22 13:21:12.768
5	40	6	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.791	2014-12-22 13:21:12.811
6	48	1	0	1	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.832	2014-12-22 13:21:12.844
7	43	7	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.87	2014-12-22 13:21:12.882
8	52	2	3	4	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.905	2014-12-22 13:21:12.916
9	56	30	5	6	0	0	0	0	\N	\N	1	1	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.949	2014-12-22 13:21:12.961
10	35	39	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:12.989	2014-12-22 13:21:13
11	61	19	2	4	2	1	2	2	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.034	2014-12-22 13:21:13.045
12	54	23	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.067	2014-12-22 13:21:13.078
13	51	38	4	1	3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.1	2014-12-22 13:21:13.114
14	62	28	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.14	2014-12-22 13:21:13.156
15	41	14	4	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.178	2014-12-22 13:21:13.194
16	60	18	1	4	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.221	2014-12-22 13:21:13.23
17	50	24	0	3	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.248	2014-12-22 13:21:13.26
18	59	32	4	5	1	1	1	1	\N	\N	1	1	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.278	2014-12-22 13:21:13.288
19	55	15	1	3	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.304	2014-12-22 13:21:13.317
20	57	17	1	5	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.334	2014-12-22 13:21:13.343
21	34	16	7	6	2	2	3	3	\N	\N	3	3	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.36	2014-12-22 13:21:13.373
22	47	21	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.39	2014-12-22 13:21:13.399
23	45	27	1	4	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.417	2014-12-22 13:21:13.434
24	25	29	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.451	2014-12-22 13:21:13.472
25	63	3	3	2	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.495	2014-12-22 13:21:13.505
26	49	8	1	5	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.521	2014-12-22 13:21:13.533
27	42	37	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.551	2014-12-22 13:21:13.566
28	22	5	1	0	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.586	2014-12-22 13:21:13.598
29	46	33	1	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.616	2014-12-22 13:21:13.625
30	64	4	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.642	2014-12-22 13:21:13.655
31	31	9	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.672	2014-12-22 13:21:13.681
32	12	26	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-29 15:30:00	f	t	1	2014-12-22 13:21:13.697	2014-12-22 13:21:13.715
33	30	20	1	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.731	2014-12-22 13:21:13.74
34	12	18	4	5	0	0	0	0	\N	\N	0	0	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.757	2014-12-22 13:21:13.768
35	4	25	2	3	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.784	2014-12-22 13:21:13.793
36	17	13	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.809	2014-12-22 13:21:13.82
37	32	21	3	5	0	0	1	1	\N	\N	2	2	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.837	2014-12-22 13:21:13.847
38	11	27	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.863	2014-12-22 13:21:13.874
39	22	10	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.892	2014-12-22 13:21:13.9
40	6	23	2	4	2	2	2	2	\N	\N	2	2	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.916	2014-12-22 13:21:13.928
41	24	2	2	3	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.945	2014-12-22 13:21:13.955
42	1	31	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.97	2014-12-22 13:21:13.982
43	41	8	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:13.998	2014-12-22 13:21:14.007
44	51	7	1	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:14.023	2014-12-22 13:21:14.034
45	34	15	2	3	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:14.052	2014-12-22 13:21:14.062
46	62	19	3	2	2	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:14.078	2014-12-22 13:21:14.091
47	33	37	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:14.107	2014-12-22 13:21:14.117
48	35	63	3	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	2	2014-12-22 13:21:14.132	2014-12-22 13:21:14.144
49	41	21	0	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.161	2014-12-22 13:21:14.17
50	35	7	2	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.186	2014-12-22 13:21:14.198
51	2	25	3	1	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.214	2014-12-22 13:21:14.224
52	18	13	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.24	2014-12-22 13:21:14.26
53	15	23	4	3	0	0	0	0	\N	\N	0	0	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.276	2014-12-22 13:21:14.285
54	62	20	1	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.301	2014-12-22 13:21:14.313
55	22	27	4	3	0	0	0	0	\N	\N	0	0	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.33	2014-12-22 13:21:14.339
56	33	1	3	4	0	0	0	0	\N	\N	0	0	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	3	2014-12-22 13:21:14.355	2014-12-22 13:21:14.367
57	15	20	0	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	4	2014-12-22 13:21:14.384	2014-12-22 13:21:14.393
58	22	1	1	3	0	0	1	1	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	4	2014-12-22 13:21:14.409	2014-12-22 13:21:14.421
59	18	21	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	4	2014-12-22 13:21:14.454	2014-12-22 13:21:14.463
60	35	2	1	3	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	4	2014-12-22 13:21:14.493	2014-12-22 13:21:14.503
61	1	2	6	4	2	2	3	3	\N	\N	3	3	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	5	2014-12-22 13:21:14.519	2014-12-22 13:21:14.528
62	20	18	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	5	2014-12-22 13:21:14.547	2014-12-22 13:21:14.557
63	18	1	0	1	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-22 15:30:00	f	t	6	2014-12-22 13:21:14.575	2014-12-22 13:21:14.587
64	7	8	2	3	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.699	2014-12-22 13:21:19.563
65	10	14	4	0	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.713	2014-12-22 13:21:19.59
66	3	13	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.729	2014-12-22 13:21:19.607
67	6	20	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.745	2014-12-22 13:21:19.626
68	19	5	2	3	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.758	2014-12-22 13:21:19.643
69	9	11	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.772	2014-12-22 13:21:19.661
70	15	4	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.787	2014-12-22 13:21:19.678
71	12	1	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.809	2014-12-22 13:21:19.695
72	2	21	3	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-08 15:30:00	f	t	7	2014-12-22 13:21:14.822	2014-12-22 13:21:19.711
73	21	12	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.849	2014-12-22 13:21:19.731
74	4	9	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.869	2014-12-22 13:21:19.749
75	11	19	0	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.884	2014-12-22 13:21:19.766
76	5	6	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.897	2014-12-22 13:21:19.79
77	20	3	3	1	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.914	2014-12-22 13:21:19.831
78	13	10	2	2	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.928	2014-12-22 13:21:19.849
79	14	7	1	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.941	2014-12-22 13:21:19.866
80	8	2	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.955	2014-12-22 13:21:19.883
81	1	15	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-15 15:30:00	f	t	8	2014-12-22 13:21:14.969	2014-12-22 13:21:19.899
82	7	13	2	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:14.991	2014-12-22 13:21:19.918
83	10	20	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.005	2014-12-22 13:21:19.935
84	3	5	3	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.019	2014-12-22 13:21:19.951
85	6	11	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.033	2014-12-22 13:21:19.968
86	19	4	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.046	2014-12-22 13:21:19.984
87	9	1	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.06	2014-12-22 13:21:20.001
88	15	21	3	1	3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.074	2014-12-22 13:21:20.016
89	8	14	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.091	2014-12-22 13:21:20.033
90	2	12	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-08-22 15:30:00	f	t	9	2014-12-22 13:21:15.105	2014-12-22 13:21:20.053
91	21	9	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.125	2014-12-22 13:21:20.075
92	4	6	1	4	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.138	2014-12-22 13:21:20.091
93	11	3	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.152	2014-12-22 13:21:20.107
94	5	10	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.165	2014-12-22 13:21:20.123
95	20	7	1	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.179	2014-12-22 13:21:20.14
96	13	8	1	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.194	2014-12-22 13:21:20.157
97	14	2	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.207	2014-12-22 13:21:20.174
98	12	15	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.221	2014-12-22 13:21:20.195
99	1	19	4	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-13 20:30:00	f	t	10	2014-12-22 13:21:15.24	2014-12-22 13:21:20.212
100	7	5	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.26	2014-12-22 13:21:20.231
101	10	11	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.274	2014-12-22 13:21:20.256
102	3	4	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.287	2014-12-22 13:21:20.282
103	6	1	0	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.301	2014-12-22 13:21:20.323
104	19	21	2	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.314	2014-12-22 13:21:20.34
105	9	12	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.328	2014-12-22 13:21:20.357
106	14	13	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.342	2014-12-22 13:21:20.373
107	8	20	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.357	2014-12-22 13:21:20.391
108	2	15	5	0	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-16 20:30:00	f	t	11	2014-12-22 13:21:15.371	2014-12-22 13:21:20.407
109	21	6	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.391	2014-12-22 13:21:20.426
110	4	10	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.407	2014-12-22 13:21:20.447
111	11	7	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.42	2014-12-22 13:21:20.479
112	5	8	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.434	2014-12-22 13:21:20.506
113	20	14	1	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.447	2014-12-22 13:21:20.525
114	13	2	1	3	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.461	2014-12-22 13:21:20.545
115	15	9	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.477	2014-12-22 13:21:20.57
116	12	19	2	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.491	2014-12-22 13:21:20.588
117	1	3	0	3	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-23 20:30:00	f	t	12	2014-12-22 13:21:15.505	2014-12-22 13:21:20.608
118	7	4	2	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.524	2014-12-22 13:21:20.657
119	10	1	1	3	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.537	2014-12-22 13:21:20.693
120	3	21	2	3	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.555	2014-12-22 13:21:20.71
121	6	12	2	1	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.572	2014-12-22 13:21:20.729
122	19	15	2	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.588	2014-12-22 13:21:20.747
123	13	20	2	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.605	2014-12-22 13:21:20.766
124	14	5	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.621	2014-12-22 13:21:20.789
125	8	11	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.638	2014-12-22 13:21:20.81
126	2	9	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-09-30 20:30:00	f	t	13	2014-12-22 13:21:15.653	2014-12-22 13:21:20.827
127	21	10	2	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.678	2014-12-22 13:21:20.848
128	4	8	0	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.692	2014-12-22 13:21:20.864
129	11	14	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.707	2014-12-22 13:21:20.882
130	5	13	1	3	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.72	2014-12-22 13:21:20.899
131	20	2	1	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.734	2014-12-22 13:21:20.918
132	9	19	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.749	2014-12-22 13:21:20.935
133	15	6	1	6	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.763	2014-12-22 13:21:20.96
134	12	3	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.779	2014-12-22 13:21:20.977
135	1	7	3	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-14 20:30:00	f	t	14	2014-12-22 13:21:15.794	2014-12-22 13:21:20.994
136	7	21	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.814	2014-12-22 13:21:21.019
137	10	12	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.829	2014-12-22 13:21:21.037
138	3	15	3	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.844	2014-12-22 13:21:21.054
139	6	9	3	2	3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.859	2014-12-22 13:21:21.077
140	20	5	1	3	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.874	2014-12-22 13:21:21.102
141	13	11	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.888	2014-12-22 13:21:21.122
142	14	4	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.902	2014-12-22 13:21:21.176
143	8	1	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.917	2014-12-22 13:21:21.223
144	2	19	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-21 20:30:00	f	t	15	2014-12-22 13:21:15.931	2014-12-22 13:21:21.24
145	21	8	1	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:15.954	2014-12-22 13:21:21.26
146	4	13	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:15.969	2014-12-22 13:21:21.283
147	11	20	2	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:15.983	2014-12-22 13:21:21.346
148	5	2	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:15.997	2014-12-22 13:21:21.382
149	19	6	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:16.011	2014-12-22 13:21:21.438
150	9	3	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:16.025	2014-12-22 13:21:21.481
151	15	10	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:16.039	2014-12-22 13:21:21.507
152	12	7	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:16.052	2014-12-22 13:21:21.523
153	1	14	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-10-28 20:30:00	f	t	16	2014-12-22 13:21:16.066	2014-12-22 13:21:21.54
154	7	15	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.086	2014-12-22 13:21:21.593
155	10	9	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.105	2014-12-22 13:21:21.725
156	3	19	3	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.12	2014-12-22 13:21:21.794
157	5	11	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.134	2014-12-22 13:21:21.853
158	20	4	1	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.147	2014-12-22 13:21:21.931
159	13	1	0	4	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.161	2014-12-22 13:21:21.994
160	14	21	2	2	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.174	2014-12-22 13:21:22.051
161	8	12	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.188	2014-12-22 13:21:22.073
162	2	6	3	3	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-04 20:30:00	f	t	17	2014-12-22 13:21:16.201	2014-12-22 13:21:22.129
163	21	13	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.22	2014-12-22 13:21:22.182
164	4	5	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.234	2014-12-22 13:21:22.2
165	11	2	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.248	2014-12-22 13:21:22.218
166	6	3	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.262	2014-12-22 13:21:22.235
167	19	10	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.275	2014-12-22 13:21:22.253
168	9	7	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.289	2014-12-22 13:21:22.27
169	15	8	2	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.303	2014-12-22 13:21:22.286
170	12	14	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.317	2014-12-22 13:21:22.303
171	1	20	3	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-11 20:30:00	f	t	18	2014-12-22 13:21:16.331	2014-12-22 13:21:22.32
172	7	19	3	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.351	2014-12-22 13:21:22.339
173	10	6	3	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.365	2014-12-22 13:21:22.355
174	11	4	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.379	2014-12-22 13:21:22.372
175	5	1	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.393	2014-12-22 13:21:22.389
176	20	21	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.407	2014-12-22 13:21:22.406
177	13	12	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.421	2014-12-22 13:21:22.423
178	14	15	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.435	2014-12-22 13:21:22.44
179	8	9	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.45	2014-12-22 13:21:22.457
180	2	3	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-11-25 20:30:00	f	t	19	2014-12-22 13:21:16.464	2014-12-22 13:21:22.48
181	21	5	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.484	2014-12-22 13:21:22.501
182	4	2	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.498	2014-12-22 13:21:22.518
183	3	10	2	1	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.518	2014-12-22 13:21:22.536
184	6	7	1	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.539	2014-12-22 13:21:22.573
185	19	8	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.559	2014-12-22 13:21:22.59
186	9	14	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.573	2014-12-22 13:21:22.608
187	15	13	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.586	2014-12-22 13:21:22.626
188	12	20	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.6	2014-12-22 13:21:22.643
189	1	11	6	2	4	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-02 20:30:00	f	t	20	2014-12-22 13:21:16.615	2014-12-22 13:21:22.663
190	7	3	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.636	2014-12-22 13:21:22.69
191	10	2	0	4	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.652	2014-12-22 13:21:22.719
192	11	21	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.666	2014-12-22 13:21:22.736
193	5	12	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.679	2014-12-22 13:21:22.756
194	20	15	1	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.694	2014-12-22 13:21:22.773
195	13	9	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.708	2014-12-22 13:21:22.791
196	14	19	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.722	2014-12-22 13:21:22.808
197	8	6	0	3	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.736	2014-12-22 13:21:22.825
198	1	4	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-09 20:30:00	f	t	21	2014-12-22 13:21:16.76	2014-12-22 13:21:22.843
199	21	4	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.786	2014-12-22 13:21:22.869
200	10	7	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.8	2014-12-22 13:21:22.886
201	3	8	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.814	2014-12-22 13:21:22.903
202	6	14	2	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.827	2014-12-22 13:21:22.92
203	19	13	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.84	2014-12-22 13:21:22.938
204	9	20	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.855	2014-12-22 13:21:22.964
205	15	5	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.869	2014-12-22 13:21:22.982
206	12	11	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.882	2014-12-22 13:21:23.01
207	2	1	4	1	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-16 20:30:00	f	t	22	2014-12-22 13:21:16.896	2014-12-22 13:21:23.043
208	7	2	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.918	2014-12-22 13:21:23.069
209	4	12	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.932	2014-12-22 13:21:23.089
210	11	15	2	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.951	2014-12-22 13:21:23.137
211	5	9	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.966	2014-12-22 13:21:23.201
212	20	19	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.98	2014-12-22 13:21:23.262
213	13	6	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:16.995	2014-12-22 13:21:23.337
214	14	3	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:17.008	2014-12-22 13:21:23.364
215	8	10	0	3	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:17.022	2014-12-22 13:21:23.434
216	1	21	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2009-12-23 20:30:00	f	t	23	2014-12-22 13:21:17.036	2014-12-22 13:21:23.456
217	8	7	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.058	2014-12-22 13:21:23.559
218	14	10	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.073	2014-12-22 13:21:23.611
219	13	3	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.088	2014-12-22 13:21:23.633
220	20	6	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.102	2014-12-22 13:21:23.67
221	5	19	1	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.116	2014-12-22 13:21:23.732
222	11	9	4	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.131	2014-12-22 13:21:23.767
223	4	15	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.145	2014-12-22 13:21:23.808
224	1	12	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.159	2014-12-22 13:21:23.844
225	21	2	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-01-27 20:30:00	f	t	24	2014-12-22 13:21:17.172	2014-12-22 13:21:23.868
226	12	21	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.195	2014-12-22 13:21:23.914
227	9	4	1	3	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.211	2014-12-22 13:21:23.935
228	19	11	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.225	2014-12-22 13:21:23.958
229	6	5	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.238	2014-12-22 13:21:23.981
230	3	20	3	2	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.253	2014-12-22 13:21:24.005
231	10	13	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.268	2014-12-22 13:21:24.028
232	7	14	3	3	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.282	2014-12-22 13:21:24.074
233	2	8	1	4	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.297	2014-12-22 13:21:24.12
234	15	1	3	3	3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-03 20:30:00	f	t	25	2014-12-22 13:21:17.31	2014-12-22 13:21:24.178
235	13	7	5	1	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.331	2014-12-22 13:21:24.214
236	20	10	1	3	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.35	2014-12-22 13:21:24.247
237	5	3	0	5	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.365	2014-12-22 13:21:24.302
238	11	6	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.379	2014-12-22 13:21:24.329
239	4	19	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.392	2014-12-22 13:21:24.352
240	1	9	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.406	2014-12-22 13:21:24.375
241	21	15	4	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.42	2014-12-22 13:21:24.399
242	14	8	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.433	2014-12-22 13:21:24.421
243	12	2	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-07 20:30:00	f	t	26	2014-12-22 13:21:17.447	2014-12-22 13:21:24.444
244	9	21	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.468	2014-12-22 13:21:24.478
245	6	4	2	4	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.481	2014-12-22 13:21:24.502
246	3	11	0	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.494	2014-12-22 13:21:24.524
247	10	5	2	3	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.509	2014-12-22 13:21:24.547
248	7	20	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.523	2014-12-22 13:21:24.573
249	8	13	2	3	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.537	2014-12-22 13:21:24.594
250	2	14	3	1	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.552	2014-12-22 13:21:24.616
251	15	12	2	3	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.568	2014-12-22 13:21:24.636
252	19	1	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-10 20:30:00	f	t	27	2014-12-22 13:21:17.582	2014-12-22 13:21:24.656
253	5	7	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.603	2014-12-22 13:21:24.715
254	11	10	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.619	2014-12-22 13:21:24.746
255	4	3	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.633	2014-12-22 13:21:24.791
256	1	6	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.648	2014-12-22 13:21:24.855
257	21	19	2	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.662	2014-12-22 13:21:24.901
258	12	9	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.677	2014-12-22 13:21:24.928
259	13	14	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.691	2014-12-22 13:21:24.992
260	20	8	1	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.704	2014-12-22 13:21:25.015
261	15	2	0	4	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-17 20:30:00	f	t	28	2014-12-22 13:21:17.719	2014-12-22 13:21:25.039
262	6	21	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.745	2014-12-22 13:21:25.067
263	10	4	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.759	2014-12-22 13:21:25.092
264	7	11	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.773	2014-12-22 13:21:25.118
265	8	5	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.787	2014-12-22 13:21:25.144
266	14	20	4	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.801	2014-12-22 13:21:25.183
267	2	13	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.814	2014-12-22 13:21:25.211
268	9	15	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.829	2014-12-22 13:21:25.238
269	19	12	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.842	2014-12-22 13:21:25.27
270	3	1	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-02-24 20:30:00	f	t	29	2014-12-22 13:21:17.857	2014-12-22 13:21:25.298
271	4	7	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.877	2014-12-22 13:21:25.326
272	1	10	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.891	2014-12-22 13:21:25.382
273	21	3	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.905	2014-12-22 13:21:25.42
274	12	6	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.918	2014-12-22 13:21:25.444
275	15	19	1	4	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.931	2014-12-22 13:21:25.475
276	20	13	2	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.946	2014-12-22 13:21:25.498
277	5	14	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.96	2014-12-22 13:21:25.54
278	11	8	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.973	2014-12-22 13:21:25.582
279	9	2	2	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-03 20:30:00	f	t	30	2014-12-22 13:21:17.987	2014-12-22 13:21:25.622
280	10	21	2	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.008	2014-12-22 13:21:25.666
281	8	4	1	4	1	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.022	2014-12-22 13:21:25.701
282	14	11	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.036	2014-12-22 13:21:25.727
283	13	5	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.051	2014-12-22 13:21:25.75
284	2	20	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.066	2014-12-22 13:21:25.79
285	19	9	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.079	2014-12-22 13:21:25.843
286	6	15	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.092	2014-12-22 13:21:25.882
287	3	12	3	0	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.111	2014-12-22 13:21:25.915
288	7	1	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-10 20:30:00	f	t	31	2014-12-22 13:21:18.125	2014-12-22 13:21:25.949
289	21	7	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.16	2014-12-22 13:21:25.981
290	12	10	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.175	2014-12-22 13:21:26.016
291	15	3	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.189	2014-12-22 13:21:26.04
292	9	6	2	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.203	2014-12-22 13:21:26.063
293	5	20	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.218	2014-12-22 13:21:26.106
294	11	13	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.232	2014-12-22 13:21:26.132
295	4	14	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.247	2014-12-22 13:21:26.158
296	1	8	1	3	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.264	2014-12-22 13:21:26.182
297	19	2	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-17 20:30:00	f	t	32	2014-12-22 13:21:18.278	2014-12-22 13:21:26.205
298	8	21	4	2	4	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.297	2014-12-22 13:21:26.252
299	13	4	3	4	3	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.311	2014-12-22 13:21:26.285
300	20	11	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.324	2014-12-22 13:21:26.311
301	2	5	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.339	2014-12-22 13:21:26.383
302	6	19	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.353	2014-12-22 13:21:26.406
303	3	9	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.367	2014-12-22 13:21:26.447
304	10	15	4	0	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.38	2014-12-22 13:21:26.485
305	7	12	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.394	2014-12-22 13:21:26.51
306	14	1	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-03-24 20:30:00	f	t	33	2014-12-22 13:21:18.408	2014-12-22 13:21:26.536
307	15	7	1	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.428	2014-12-22 13:21:26.585
308	9	10	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.443	2014-12-22 13:21:26.611
309	19	3	2	3	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.458	2014-12-22 13:21:26.637
310	11	5	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.472	2014-12-22 13:21:26.664
311	4	20	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.491	2014-12-22 13:21:26.692
312	1	13	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.505	2014-12-22 13:21:26.716
313	21	14	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.519	2014-12-22 13:21:26.741
314	12	8	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.533	2014-12-22 13:21:26.766
315	6	2	0	3	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-07 20:30:00	f	t	34	2014-12-22 13:21:18.547	2014-12-22 13:21:26.808
316	13	21	2	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.575	2014-12-22 13:21:26.833
317	5	4	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.589	2014-12-22 13:21:26.855
318	2	11	3	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.603	2014-12-22 13:21:26.886
319	3	6	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.618	2014-12-22 13:21:26.913
320	10	19	2	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.634	2014-12-22 13:21:26.941
321	7	9	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.648	2014-12-22 13:21:26.965
322	8	15	2	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.661	2014-12-22 13:21:27.013
323	14	12	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.675	2014-12-22 13:21:27.045
324	20	1	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-14 20:30:00	f	t	35	2014-12-22 13:21:18.689	2014-12-22 13:21:27.076
325	19	7	1	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.709	2014-12-22 13:21:27.115
326	6	10	2	2	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.723	2014-12-22 13:21:27.141
327	4	11	1	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.737	2014-12-22 13:21:27.166
328	1	5	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.752	2014-12-22 13:21:27.19
329	21	20	3	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.766	2014-12-22 13:21:27.215
330	12	13	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.78	2014-12-22 13:21:27.259
331	15	14	2	2	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.795	2014-12-22 13:21:27.288
332	9	8	4	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.809	2014-12-22 13:21:27.314
333	3	2	2	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-21 20:30:00	f	t	36	2014-12-22 13:21:18.823	2014-12-22 13:21:27.339
334	5	21	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.843	2014-12-22 13:21:27.37
335	2	4	2	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.863	2014-12-22 13:21:27.394
336	10	3	1	3	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.876	2014-12-22 13:21:27.421
337	7	6	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.891	2014-12-22 13:21:27.447
338	8	19	0	2	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.904	2014-12-22 13:21:27.502
339	14	9	0	2	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.919	2014-12-22 13:21:27.534
340	13	15	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.932	2014-12-22 13:21:27.573
341	20	12	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.946	2014-12-22 13:21:27.595
342	11	1	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-04-28 20:30:00	f	t	37	2014-12-22 13:21:18.96	2014-12-22 13:21:27.617
343	3	7	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:18.98	2014-12-22 13:21:27.642
344	2	10	3	1	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:18.994	2014-12-22 13:21:27.66
345	21	11	2	2	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.008	2014-12-22 13:21:27.683
346	12	5	1	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.022	2014-12-22 13:21:27.715
347	15	20	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.036	2014-12-22 13:21:27.746
348	9	13	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.05	2014-12-22 13:21:27.813
349	19	14	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.064	2014-12-22 13:21:27.845
350	6	8	0	2	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.078	2014-12-22 13:21:27.868
351	4	1	0	1	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-05 20:30:00	f	t	38	2014-12-22 13:21:19.091	2014-12-22 13:21:27.9
352	4	21	3	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.111	2014-12-22 13:21:27.932
353	7	10	2	1	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.125	2014-12-22 13:21:27.962
354	8	3	1	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.14	2014-12-22 13:21:27.992
355	14	6	1	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.161	2014-12-22 13:21:28.024
356	13	19	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.185	2014-12-22 13:21:28.058
357	20	9	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.21	2014-12-22 13:21:28.083
358	5	15	1	3	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.234	2014-12-22 13:21:28.103
359	11	12	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.266	2014-12-22 13:21:28.131
360	1	2	2	0	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-12 20:30:00	f	t	39	2014-12-22 13:21:19.291	2014-12-22 13:21:28.16
361	2	7	0	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.326	2014-12-22 13:21:28.196
362	12	4	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.351	2014-12-22 13:21:28.227
363	15	11	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.376	2014-12-22 13:21:28.266
364	9	5	2	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.401	2014-12-22 13:21:28.291
365	19	20	1	0	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.426	2014-12-22 13:21:28.319
366	6	13	0	3	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.45	2014-12-22 13:21:28.34
367	3	14	3	0	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.48	2014-12-22 13:21:28.36
368	10	8	1	1	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.504	2014-12-22 13:21:28.383
369	21	1	0	1	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	2010-05-19 20:30:00	f	t	40	2014-12-22 13:21:19.528	2014-12-22 13:21:28.411
\.


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('games_id_seq', 369, true);


--
-- Data for Name: matchdays; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY matchdays (id, number, start, competition_id, created_at, updated_at) FROM stdin;
1	1	2009-08-29 15:30:00	1	2014-12-22 13:21:12.39	2014-12-22 13:21:12.39
2	1	2009-08-08 15:30:00	2	2014-12-22 13:21:14.683	2014-12-22 13:21:14.683
3	2	2009-08-15 15:30:00	2	2014-12-22 13:21:14.834	2014-12-22 13:21:14.834
4	2	2009-10-28 20:30:00	1	2014-12-22 13:21:12.468	2014-12-22 13:21:12.468
5	3	2009-08-22 15:30:00	2	2014-12-22 13:21:14.98	2014-12-22 13:21:14.98
6	3	2009-12-16 20:30:00	1	2014-12-22 13:21:12.482	2014-12-22 13:21:12.482
7	4	2009-09-13 20:30:00	2	2014-12-22 13:21:15.117	2014-12-22 13:21:15.117
8	4	2010-03-03 20:30:00	1	2014-12-22 13:21:12.495	2014-12-22 13:21:12.495
9	5	2009-09-16 20:30:00	2	2014-12-22 13:21:15.252	2014-12-22 13:21:15.252
10	5	2010-04-14 20:30:00	1	2014-12-22 13:21:12.509	2014-12-22 13:21:12.509
11	6	2010-05-22 15:30:00	1	2014-12-22 13:21:12.523	2014-12-22 13:21:12.523
12	6	2009-09-23 20:30:00	2	2014-12-22 13:21:15.383	2014-12-22 13:21:15.383
13	7	2009-09-30 20:30:00	2	2014-12-22 13:21:15.516	2014-12-22 13:21:15.516
14	8	2009-10-14 20:30:00	2	2014-12-22 13:21:15.664	2014-12-22 13:21:15.664
15	9	2009-10-21 20:30:00	2	2014-12-22 13:21:15.806	2014-12-22 13:21:15.806
16	10	2009-10-28 20:30:00	2	2014-12-22 13:21:15.945	2014-12-22 13:21:15.945
17	11	2009-11-04 20:30:00	2	2014-12-22 13:21:16.078	2014-12-22 13:21:16.078
18	12	2009-11-11 20:30:00	2	2014-12-22 13:21:16.212	2014-12-22 13:21:16.212
19	13	2009-11-25 20:30:00	2	2014-12-22 13:21:16.342	2014-12-22 13:21:16.342
20	14	2009-12-02 20:30:00	2	2014-12-22 13:21:16.476	2014-12-22 13:21:16.476
21	15	2009-12-09 20:30:00	2	2014-12-22 13:21:16.627	2014-12-22 13:21:16.627
22	16	2009-12-16 20:30:00	2	2014-12-22 13:21:16.778	2014-12-22 13:21:16.778
23	17	2009-12-23 20:30:00	2	2014-12-22 13:21:16.909	2014-12-22 13:21:16.909
24	18	2010-01-27 20:30:00	2	2014-12-22 13:21:17.05	2014-12-22 13:21:17.05
25	19	2010-02-03 20:30:00	2	2014-12-22 13:21:17.184	2014-12-22 13:21:17.184
26	20	2010-02-07 20:30:00	2	2014-12-22 13:21:17.323	2014-12-22 13:21:17.323
27	21	2010-02-10 20:30:00	2	2014-12-22 13:21:17.46	2014-12-22 13:21:17.46
28	22	2010-02-17 20:30:00	2	2014-12-22 13:21:17.594	2014-12-22 13:21:17.594
29	23	2010-02-24 20:30:00	2	2014-12-22 13:21:17.736	2014-12-22 13:21:17.736
30	24	2010-03-03 20:30:00	2	2014-12-22 13:21:17.869	2014-12-22 13:21:17.869
31	25	2010-03-10 20:30:00	2	2014-12-22 13:21:18	2014-12-22 13:21:18
32	26	2010-03-17 20:30:00	2	2014-12-22 13:21:18.144	2014-12-22 13:21:18.144
33	27	2010-03-24 20:30:00	2	2014-12-22 13:21:18.289	2014-12-22 13:21:18.289
34	28	2010-04-07 20:30:00	2	2014-12-22 13:21:18.42	2014-12-22 13:21:18.42
35	29	2010-04-14 20:30:00	2	2014-12-22 13:21:18.566	2014-12-22 13:21:18.566
36	30	2010-04-21 20:30:00	2	2014-12-22 13:21:18.7	2014-12-22 13:21:18.7
37	31	2010-04-28 20:30:00	2	2014-12-22 13:21:18.835	2014-12-22 13:21:18.835
38	32	2010-05-05 20:30:00	2	2014-12-22 13:21:18.972	2014-12-22 13:21:18.972
39	33	2010-05-12 20:30:00	2	2014-12-22 13:21:19.103	2014-12-22 13:21:19.103
40	34	2010-05-19 20:30:00	2	2014-12-22 13:21:19.312	2014-12-22 13:21:19.312
\.


--
-- Name: matchdays_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('matchdays_id_seq', 40, true);


--
-- Data for Name: points; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY points (id, points, goals, against, diff, win, draw, lost, level, game_id, team_id, league_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('points_id_seq', 1, false);


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY results (id, points, goals, against, diff, win, draw, lost, team_id, league_id, level, year, rank, created_at, updated_at) FROM stdin;
1	69	56	32	24	21	6	7	1	2	1	2010	1	2014-12-22 13:21:29.337	2014-12-22 13:21:29.337
2	67	64	32	32	20	7	7	2	2	1	2010	2	2014-12-22 13:21:29.345	2014-12-22 13:21:29.345
3	65	58	39	19	20	5	9	3	2	1	2010	3	2014-12-22 13:21:29.353	2014-12-22 13:21:29.353
4	52	44	37	7	14	10	10	4	2	1	2010	4	2014-12-22 13:21:29.36	2014-12-22 13:21:29.36
5	48	34	37	-3	12	12	10	5	2	1	2010	5	2014-12-22 13:21:29.366	2014-12-22 13:21:29.366
6	46	46	48	-2	13	7	14	6	2	1	2010	6	2014-12-22 13:21:29.372	2014-12-22 13:21:29.372
7	45	37	43	-6	11	12	11	7	2	1	2010	7	2014-12-22 13:21:29.377	2014-12-22 13:21:29.377
8	44	47	52	-5	12	8	14	8	2	1	2010	8	2014-12-22 13:21:29.382	2014-12-22 13:21:29.382
9	44	35	40	-5	10	14	10	9	2	1	2010	9	2014-12-22 13:21:29.387	2014-12-22 13:21:29.387
10	41	50	47	3	9	14	11	10	2	1	2010	10	2014-12-22 13:21:29.393	2014-12-22 13:21:29.393
11	40	41	43	-2	9	13	12	11	2	1	2010	11	2014-12-22 13:21:29.397	2014-12-22 13:21:29.397
12	40	27	36	-9	9	13	12	12	2	1	2010	12	2014-12-22 13:21:29.403	2014-12-22 13:21:29.403
13	39	44	45	-1	9	12	13	13	2	1	2010	13	2014-12-22 13:21:29.407	2014-12-22 13:21:29.407
14	39	36	46	-10	9	12	13	14	2	1	2010	14	2014-12-22 13:21:29.413	2014-12-22 13:21:29.413
15	38	44	63	-19	9	11	14	15	2	1	2010	15	2014-12-22 13:21:29.419	2014-12-22 13:21:29.419
16	37	41	47	-6	9	10	15	19	2	1	2010	16	2014-12-22 13:21:29.426	2014-12-22 13:21:29.426
17	36	42	51	-9	9	9	16	20	2	1	2010	17	2014-12-22 13:21:29.431	2014-12-22 13:21:29.431
18	34	42	50	-8	7	13	14	21	2	1	2010	18	2014-12-22 13:21:29.438	2014-12-22 13:21:29.438
19	65	76	42	34	20	5	9	16	3	2	2010	1	2014-12-22 13:21:29.456	2014-12-22 13:21:29.456
20	64	62	36	26	18	10	6	17	3	2	2010	2	2014-12-22 13:21:29.467	2014-12-22 13:21:29.467
21	61	53	34	19	16	13	5	18	3	2	2010	3	2014-12-22 13:21:29.476	2014-12-22 13:21:29.476
22	57	45	27	18	17	6	11	22	3	2	2010	4	2014-12-22 13:21:29.486	2014-12-22 13:21:29.486
23	57	52	37	15	17	6	11	23	3	2	2010	5	2014-12-22 13:21:29.5	2014-12-22 13:21:29.5
24	56	47	48	-1	16	8	10	24	3	2	2010	6	2014-12-22 13:21:29.508	2014-12-22 13:21:29.508
25	52	54	37	17	14	10	10	25	3	2	2010	7	2014-12-22 13:21:29.516	2014-12-22 13:21:29.516
26	50	47	40	7	14	8	12	26	3	2	2010	8	2014-12-22 13:21:29.524	2014-12-22 13:21:29.524
27	47	46	50	-4	14	5	15	27	3	2	2010	9	2014-12-22 13:21:29.534	2014-12-22 13:21:29.534
28	47	31	41	-10	11	14	9	28	3	2	2010	10	2014-12-22 13:21:29.543	2014-12-22 13:21:29.543
29	46	31	39	-8	12	10	12	29	3	2	2010	11	2014-12-22 13:21:29.553	2014-12-22 13:21:29.553
30	41	39	44	-5	9	14	11	30	3	2	2010	12	2014-12-22 13:21:29.563	2014-12-22 13:21:29.563
31	39	47	59	-12	10	9	15	31	3	2	2010	13	2014-12-22 13:21:29.574	2014-12-22 13:21:29.574
32	35	39	55	-16	10	5	19	32	3	2	2010	14	2014-12-22 13:21:29.593	2014-12-22 13:21:29.593
33	32	36	52	-16	8	8	18	33	3	2	2010	15	2014-12-22 13:21:29.604	2014-12-22 13:21:29.604
34	32	44	66	-22	8	8	18	37	3	2	2010	16	2014-12-22 13:21:29.614	2014-12-22 13:21:29.614
35	31	38	64	-26	9	4	21	38	3	2	2010	17	2014-12-22 13:21:29.625	2014-12-22 13:21:29.625
36	30	27	43	-16	7	9	18	39	3	2	2010	18	2014-12-22 13:21:29.649	2014-12-22 13:21:29.649
37	77	58	24	34	24	5	5	34	4	3	2010	1	2014-12-22 13:21:29.669	2014-12-22 13:21:29.669
38	67	57	25	32	19	10	5	35	4	3	2010	2	2014-12-22 13:21:29.682	2014-12-22 13:21:29.682
39	64	48	27	21	17	13	4	36	4	3	2010	3	2014-12-22 13:21:29.702	2014-12-22 13:21:29.702
40	61	43	25	18	18	7	9	40	4	3	2010	4	2014-12-22 13:21:29.711	2014-12-22 13:21:29.711
41	56	51	35	16	16	8	10	41	4	3	2010	5	2014-12-22 13:21:29.721	2014-12-22 13:21:29.721
42	52	40	33	7	15	7	12	42	4	3	2010	6	2014-12-22 13:21:29.731	2014-12-22 13:21:29.731
43	52	41	36	5	13	13	8	43	4	3	2010	7	2014-12-22 13:21:29.752	2014-12-22 13:21:29.752
44	42	41	51	-10	13	3	18	44	4	3	2010	8	2014-12-22 13:21:29.777	2014-12-22 13:21:29.777
45	42	39	52	-13	10	12	12	45	4	3	2010	9	2014-12-22 13:21:29.796	2014-12-22 13:21:29.796
46	41	41	41	0	11	8	15	46	4	3	2010	10	2014-12-22 13:21:29.805	2014-12-22 13:21:29.805
47	40	29	32	-3	10	10	14	47	4	3	2010	11	2014-12-22 13:21:29.816	2014-12-22 13:21:29.816
48	39	37	40	-3	10	9	15	48	4	3	2010	12	2014-12-22 13:21:29.837	2014-12-22 13:21:29.837
49	38	30	39	-9	9	11	14	49	4	3	2010	13	2014-12-22 13:21:29.846	2014-12-22 13:21:29.846
50	37	25	35	-10	9	10	15	50	4	3	2010	14	2014-12-22 13:21:29.855	2014-12-22 13:21:29.855
51	36	33	48	-15	9	9	16	51	4	3	2010	15	2014-12-22 13:21:29.863	2014-12-22 13:21:29.863
52	33	39	56	-17	8	9	17	52	4	3	2010	16	2014-12-22 13:21:29.876	2014-12-22 13:21:29.876
53	33	35	59	-24	9	6	19	53	4	3	2010	17	2014-12-22 13:21:29.899	2014-12-22 13:21:29.899
54	30	30	59	-29	8	6	20	55	4	3	2010	18	2014-12-22 13:21:29.919	2014-12-22 13:21:29.919
55	\N	\N	\N	\N	\N	\N	\N	54	5	4	2010	1	2014-12-22 13:21:29.937	2014-12-22 13:21:29.937
56	\N	\N	\N	\N	\N	\N	\N	56	5	4	2010	2	2014-12-22 13:21:29.947	2014-12-22 13:21:29.947
57	\N	\N	\N	\N	\N	\N	\N	57	5	4	2010	3	2014-12-22 13:21:29.955	2014-12-22 13:21:29.955
58	\N	\N	\N	\N	\N	\N	\N	58	5	4	2010	4	2014-12-22 13:21:29.963	2014-12-22 13:21:29.963
59	\N	\N	\N	\N	\N	\N	\N	59	5	4	2010	5	2014-12-22 13:21:29.986	2014-12-22 13:21:29.986
60	\N	\N	\N	\N	\N	\N	\N	67	5	4	2010	6	2014-12-22 13:21:30.002	2014-12-22 13:21:30.002
61	\N	\N	\N	\N	\N	\N	\N	87	5	4	2010	7	2014-12-22 13:21:30.011	2014-12-22 13:21:30.011
62	\N	\N	\N	\N	\N	\N	\N	60	5	4	2010	8	2014-12-22 13:21:30.025	2014-12-22 13:21:30.025
63	\N	\N	\N	\N	\N	\N	\N	65	5	4	2010	9	2014-12-22 13:21:30.042	2014-12-22 13:21:30.042
64	\N	\N	\N	\N	\N	\N	\N	61	5	4	2010	10	2014-12-22 13:21:30.052	2014-12-22 13:21:30.052
65	\N	\N	\N	\N	\N	\N	\N	66	5	4	2010	11	2014-12-22 13:21:30.06	2014-12-22 13:21:30.06
66	\N	\N	\N	\N	\N	\N	\N	62	5	4	2010	12	2014-12-22 13:21:30.072	2014-12-22 13:21:30.072
67	\N	\N	\N	\N	\N	\N	\N	64	5	4	2010	13	2014-12-22 13:21:30.097	2014-12-22 13:21:30.097
68	\N	\N	\N	\N	\N	\N	\N	68	5	4	2010	14	2014-12-22 13:21:30.112	2014-12-22 13:21:30.112
69	\N	\N	\N	\N	\N	\N	\N	69	5	4	2010	15	2014-12-22 13:21:30.147	2014-12-22 13:21:30.147
70	\N	\N	\N	\N	\N	\N	\N	71	5	4	2010	16	2014-12-22 13:21:30.159	2014-12-22 13:21:30.159
71	\N	\N	\N	\N	\N	\N	\N	63	5	4	2010	17	2014-12-22 13:21:30.17	2014-12-22 13:21:30.17
72	\N	\N	\N	\N	\N	\N	\N	70	5	4	2010	18	2014-12-22 13:21:30.19	2014-12-22 13:21:30.19
73	\N	\N	\N	\N	\N	\N	\N	72	6	5	2010	1	2014-12-22 13:21:30.212	2014-12-22 13:21:30.212
74	\N	\N	\N	\N	\N	\N	\N	73	6	5	2010	2	2014-12-22 13:21:30.222	2014-12-22 13:21:30.222
75	\N	\N	\N	\N	\N	\N	\N	74	6	5	2010	3	2014-12-22 13:21:30.236	2014-12-22 13:21:30.236
76	\N	\N	\N	\N	\N	\N	\N	75	6	5	2010	4	2014-12-22 13:21:30.245	2014-12-22 13:21:30.245
77	\N	\N	\N	\N	\N	\N	\N	76	6	5	2010	5	2014-12-22 13:21:30.255	2014-12-22 13:21:30.255
78	\N	\N	\N	\N	\N	\N	\N	77	6	5	2010	6	2014-12-22 13:21:30.266	2014-12-22 13:21:30.266
79	\N	\N	\N	\N	\N	\N	\N	78	6	5	2010	7	2014-12-22 13:21:30.274	2014-12-22 13:21:30.274
80	\N	\N	\N	\N	\N	\N	\N	79	6	5	2010	8	2014-12-22 13:21:30.285	2014-12-22 13:21:30.285
81	\N	\N	\N	\N	\N	\N	\N	80	6	5	2010	9	2014-12-22 13:21:30.294	2014-12-22 13:21:30.294
82	\N	\N	\N	\N	\N	\N	\N	81	6	5	2010	10	2014-12-22 13:21:30.302	2014-12-22 13:21:30.302
83	\N	\N	\N	\N	\N	\N	\N	82	6	5	2010	11	2014-12-22 13:21:30.311	2014-12-22 13:21:30.311
84	\N	\N	\N	\N	\N	\N	\N	83	6	5	2010	12	2014-12-22 13:21:30.322	2014-12-22 13:21:30.322
85	\N	\N	\N	\N	\N	\N	\N	84	6	5	2010	13	2014-12-22 13:21:30.336	2014-12-22 13:21:30.336
86	\N	\N	\N	\N	\N	\N	\N	85	6	5	2010	14	2014-12-22 13:21:30.35	2014-12-22 13:21:30.35
87	\N	\N	\N	\N	\N	\N	\N	86	6	5	2010	15	2014-12-22 13:21:30.367	2014-12-22 13:21:30.367
88	\N	\N	\N	\N	\N	\N	\N	88	6	5	2010	16	2014-12-22 13:21:30.39	2014-12-22 13:21:30.39
89	\N	\N	\N	\N	\N	\N	\N	89	6	5	2010	17	2014-12-22 13:21:30.405	2014-12-22 13:21:30.405
90	\N	\N	\N	\N	\N	\N	\N	90	6	5	2010	18	2014-12-22 13:21:30.417	2014-12-22 13:21:30.417
91	\N	\N	\N	\N	\N	\N	\N	91	7	6	2010	1	2014-12-22 13:21:30.445	2014-12-22 13:21:30.445
92	\N	\N	\N	\N	\N	\N	\N	92	7	6	2010	2	2014-12-22 13:21:30.453	2014-12-22 13:21:30.453
93	\N	\N	\N	\N	\N	\N	\N	93	7	6	2010	3	2014-12-22 13:21:30.468	2014-12-22 13:21:30.468
94	\N	\N	\N	\N	\N	\N	\N	94	7	6	2010	4	2014-12-22 13:21:30.481	2014-12-22 13:21:30.481
95	\N	\N	\N	\N	\N	\N	\N	95	7	6	2010	5	2014-12-22 13:21:30.501	2014-12-22 13:21:30.501
96	\N	\N	\N	\N	\N	\N	\N	96	7	6	2010	6	2014-12-22 13:21:30.518	2014-12-22 13:21:30.518
97	\N	\N	\N	\N	\N	\N	\N	97	7	6	2010	7	2014-12-22 13:21:30.542	2014-12-22 13:21:30.542
98	\N	\N	\N	\N	\N	\N	\N	98	7	6	2010	8	2014-12-22 13:21:30.566	2014-12-22 13:21:30.566
99	\N	\N	\N	\N	\N	\N	\N	99	7	6	2010	9	2014-12-22 13:21:30.59	2014-12-22 13:21:30.59
100	\N	\N	\N	\N	\N	\N	\N	100	7	6	2010	10	2014-12-22 13:21:30.606	2014-12-22 13:21:30.606
101	\N	\N	\N	\N	\N	\N	\N	101	7	6	2010	11	2014-12-22 13:21:30.62	2014-12-22 13:21:30.62
102	\N	\N	\N	\N	\N	\N	\N	102	7	6	2010	12	2014-12-22 13:21:30.641	2014-12-22 13:21:30.641
103	\N	\N	\N	\N	\N	\N	\N	103	7	6	2010	13	2014-12-22 13:21:30.65	2014-12-22 13:21:30.65
104	\N	\N	\N	\N	\N	\N	\N	104	7	6	2010	14	2014-12-22 13:21:30.658	2014-12-22 13:21:30.658
105	\N	\N	\N	\N	\N	\N	\N	105	7	6	2010	15	2014-12-22 13:21:30.666	2014-12-22 13:21:30.666
106	\N	\N	\N	\N	\N	\N	\N	106	7	6	2010	16	2014-12-22 13:21:30.674	2014-12-22 13:21:30.674
107	\N	\N	\N	\N	\N	\N	\N	107	7	6	2010	17	2014-12-22 13:21:30.685	2014-12-22 13:21:30.685
108	\N	\N	\N	\N	\N	\N	\N	108	7	6	2010	18	2014-12-22 13:21:30.695	2014-12-22 13:21:30.695
109	\N	\N	\N	\N	\N	\N	\N	109	8	6	2010	1	2014-12-22 13:21:30.718	2014-12-22 13:21:30.718
110	\N	\N	\N	\N	\N	\N	\N	110	8	6	2010	2	2014-12-22 13:21:30.728	2014-12-22 13:21:30.728
111	\N	\N	\N	\N	\N	\N	\N	111	8	6	2010	3	2014-12-22 13:21:30.738	2014-12-22 13:21:30.738
112	\N	\N	\N	\N	\N	\N	\N	112	8	6	2010	4	2014-12-22 13:21:30.749	2014-12-22 13:21:30.749
113	\N	\N	\N	\N	\N	\N	\N	113	8	6	2010	5	2014-12-22 13:21:30.757	2014-12-22 13:21:30.757
114	\N	\N	\N	\N	\N	\N	\N	114	8	6	2010	6	2014-12-22 13:21:30.806	2014-12-22 13:21:30.806
115	\N	\N	\N	\N	\N	\N	\N	115	8	6	2010	7	2014-12-22 13:21:30.82	2014-12-22 13:21:30.82
116	\N	\N	\N	\N	\N	\N	\N	116	8	6	2010	8	2014-12-22 13:21:30.83	2014-12-22 13:21:30.83
117	\N	\N	\N	\N	\N	\N	\N	117	8	6	2010	9	2014-12-22 13:21:30.846	2014-12-22 13:21:30.846
118	\N	\N	\N	\N	\N	\N	\N	118	8	6	2010	10	2014-12-22 13:21:30.87	2014-12-22 13:21:30.87
119	\N	\N	\N	\N	\N	\N	\N	119	8	6	2010	11	2014-12-22 13:21:30.885	2014-12-22 13:21:30.885
120	\N	\N	\N	\N	\N	\N	\N	120	8	6	2010	12	2014-12-22 13:21:30.891	2014-12-22 13:21:30.891
121	\N	\N	\N	\N	\N	\N	\N	121	8	6	2010	13	2014-12-22 13:21:30.905	2014-12-22 13:21:30.905
122	\N	\N	\N	\N	\N	\N	\N	122	8	6	2010	14	2014-12-22 13:21:30.925	2014-12-22 13:21:30.925
123	\N	\N	\N	\N	\N	\N	\N	123	8	6	2010	15	2014-12-22 13:21:30.942	2014-12-22 13:21:30.942
124	\N	\N	\N	\N	\N	\N	\N	124	8	6	2010	16	2014-12-22 13:21:30.957	2014-12-22 13:21:30.957
125	\N	\N	\N	\N	\N	\N	\N	125	8	6	2010	17	2014-12-22 13:21:30.97	2014-12-22 13:21:30.97
126	\N	\N	\N	\N	\N	\N	\N	126	8	6	2010	18	2014-12-22 13:21:30.99	2014-12-22 13:21:30.99
\.


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('results_id_seq', 126, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY schema_migrations (version) FROM stdin;
20130720152216
20130720152236
20130720152249
20130730185519
20141018091458
20141018092803
20141018113936
20141018123317
20141018155603
20141019070628
20141019070648
20141102065603
\.


--
-- Data for Name: seasons; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY seasons (id, year, start, created_at, updated_at) FROM stdin;
1	2010	2009-08-08 15:30:00	2014-12-22 13:21:12.245	2014-12-22 13:21:12.245
\.


--
-- Name: seasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('seasons_id_seq', 1, true);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: dwiedenbruch
--

COPY teams (id, name, short_name, abbreviation, federation_id, created_at, updated_at) FROM stdin;
1	Borussia Dortmund	Dortmund	BVB	1	2014-12-16 08:06:54.354	2014-12-16 08:06:54.354
2	1.FC Nürnberg	Nürnberg	FCN	1	2014-12-16 08:06:54.368	2014-12-16 08:06:54.368
3	1.FC Lokomotive Leipzig	Leipzig	Lok	1	2014-12-16 08:06:54.375	2014-12-16 08:06:54.375
4	SV Hannover 96	Hannover	H96	1	2014-12-16 08:06:54.389	2014-12-16 08:06:54.389
5	Stutgarter Kickers	Stuttg.K.	StK	1	2014-12-16 08:06:54.395	2014-12-16 08:06:54.395
6	Rot-Weiß Frankfurt	RW Frankf.	RWF	1	2014-12-16 08:06:54.404	2014-12-16 08:06:54.404
7	SC Freiburg	Freiburg	SCF	1	2014-12-16 08:06:54.418	2014-12-16 08:06:54.418
8	Karlsruher SC	Karlsruhe	KSC	1	2014-12-16 08:06:54.427	2014-12-16 08:06:54.427
9	Hertha BSC Berlin	Berlin	BSC	1	2014-12-16 08:06:54.433	2014-12-16 08:06:54.433
10	FC Carl-Zeiss Jena	Jena	CZJ	1	2014-12-16 08:06:54.443	2014-12-16 08:06:54.443
11	VfB Stuttgart	Stuttg.	VfB	1	2014-12-16 08:06:54.454	2014-12-16 08:06:54.454
12	FC Bayern München	Bayern	FCB	1	2014-12-16 08:06:54.463	2014-12-16 08:06:54.463
13	Eintracht Frankfurt	Frankfurt	SGE	1	2014-12-16 08:06:54.474	2014-12-16 08:06:54.474
14	KSV Hessen Kassel	Kassel	KSV	1	2014-12-16 08:06:54.48	2014-12-16 08:06:54.48
15	SV Werder Bremen	Bremen	SVW	1	2014-12-16 08:06:54.489	2014-12-16 08:06:54.489
16	Eintracht Braunschweig	B'schweig	EBs	1	2014-12-16 08:06:54.496	2014-12-16 08:06:54.496
17	FC Hansa Rostock	Rostock	HRo	1	2014-12-16 08:06:54.502	2014-12-16 08:06:54.502
18	1.FSV Mainz 05	Mainz	M05	1	2014-12-16 08:06:54.508	2014-12-16 08:06:54.508
19	Schalke 04 Gelsenkirchen	Schalke	S04	1	2014-12-16 08:06:54.523	2014-12-16 08:06:54.523
20	VfL Bochum	Bochum	VfL	1	2014-12-16 08:06:54.534	2014-12-16 08:06:54.534
21	Rot-Weiß Essen	Essen	RWE	1	2014-12-16 08:06:54.541	2014-12-16 08:06:54.541
22	1.FC Köln	Köln	1FC	1	2014-12-16 08:06:54.559	2014-12-16 08:06:54.559
23	DSC Arminia Bielefeld	Bielefeld	DSC	1	2014-12-16 08:06:54.57	2014-12-16 08:06:54.57
24	Alemannia Aachen	Aachen	AAa	1	2014-12-16 08:06:54.58	2014-12-16 08:06:54.58
25	SG Dynamo Dresden	Dresden	SGD	1	2014-12-16 08:06:54.587	2014-12-16 08:06:54.587
26	Hamburger SV	Hamburg	HSV	1	2014-12-16 08:06:54.598	2014-12-16 08:06:54.598
27	TSV 1860 München	TSV 1860	TSV	1	2014-12-16 08:06:54.61	2014-12-16 08:06:54.61
28	Fortuna Düsseldorf	Fortuna	F95	1	2014-12-16 08:06:54.618	2014-12-16 08:06:54.618
29	TSG 1899 Hoffenheim	Hoffenheim	TSG	1	2014-12-16 08:06:54.626	2014-12-16 08:06:54.626
30	SSV Ulm 1846	Ulm	SSV	1	2014-12-16 08:06:54.638	2014-12-16 08:06:54.638
31	Bayer 04 Leverkusen	Leverkusen	B04	1	2014-12-16 08:06:54.646	2014-12-16 08:06:54.646
32	MSV Duisburg	Duisburg	MSV	1	2014-12-16 08:06:54.651	2014-12-16 08:06:54.651
33	SV Darmstadt 98	Darmstadt	SVD	1	2014-12-16 08:06:54.657	2014-12-16 08:06:54.657
34	1.FC Kaiserlautern	Lautern	FCK	1	2014-12-16 08:06:54.667	2014-12-16 08:06:54.667
35	FV Duisburg 08	FV DU 08	FVD	1	2014-12-16 08:06:54.673	2014-12-16 08:06:54.673
36	FC Union Ruhr Essen	FCU Ruhr	FCU	1	2014-12-16 08:06:54.683	2014-12-16 08:06:54.683
37	1.FC Saarbrücken	Saarbrück.	FCS	1	2014-12-16 08:06:54.693	2014-12-16 08:06:54.693
38	Rot-Weiß Oberhausen	Oberhausen	RWO	1	2014-12-16 08:06:54.698	2014-12-16 08:06:54.698
39	VfL Wolfsburg	Wolfsburg	Wol	1	2014-12-16 08:06:54.708	2014-12-16 08:06:54.708
40	Bor. Mönchengladbach	Gladbach	BMg	1	2014-12-16 08:06:54.718	2014-12-16 08:06:54.718
41	1.FC Magdeburg	Magdeburg	FCM	1	2014-12-16 08:06:54.727	2014-12-16 08:06:54.727
42	SpVgg Greuther Fürth	Fürth	GrF	1	2014-12-16 08:06:54.733	2014-12-16 08:06:54.733
43	FC Energie Cottbus	Cottbus	FCE	1	2014-12-16 08:06:54.739	2014-12-16 08:06:54.739
44	Wuppertaler SV	Wuppertal	WSV	1	2014-12-16 08:06:54.749	2014-12-16 08:06:54.749
45	SC Preußen Münster	Münster	PrM	1	2014-12-16 08:06:54.755	2014-12-16 08:06:54.755
46	FC Rot-Weiß Erfurt	Erfurt	Erf	1	2014-12-16 08:06:54.766	2014-12-16 08:06:54.766
47	FC Erzgebirge Aue	Aue	Aue	1	2014-12-16 08:06:54.778	2014-12-16 08:06:54.778
48	FSV Frankfurt	FSV Fr.	FSV	1	2014-12-16 08:06:54.784	2014-12-16 08:06:54.784
49	1.FC Union Berlin	U.Berlin	UnB	1	2014-12-16 08:06:54.795	2014-12-16 08:06:54.795
50	FC Augsburg	Augsburg	FCA	1	2014-12-16 08:06:54.801	2014-12-16 08:06:54.801
51	KFC Uerdingen	Uerdingen	KFC	1	2014-12-16 08:06:54.808	2014-12-16 08:06:54.808
52	TuS Koblenz	Koblenz	Kob	1	2014-12-16 08:06:54.82	2014-12-16 08:06:54.82
53	VfB Lübeck	Lübeck	Lüb	1	2014-12-16 08:06:54.83	2014-12-16 08:06:54.83
54	FC Dynamo Berlin	Dynamo	BFC	1	2014-12-16 08:06:54.837	2014-12-16 08:06:54.837
55	Kickers Offenbach	Offenbach	KOf	1	2014-12-16 08:06:54.844	2014-12-16 08:06:54.844
56	FC Leverkusen	FC Lever.	FCL	1	2014-12-16 08:06:54.852	2014-12-16 08:06:54.852
57	SG Wattenscheid 09	Wattensch.	SGW	1	2014-12-16 08:06:54.861	2014-12-16 08:06:54.861
58	FC Utopia München	Utopia	UtM	1	2014-12-16 08:06:54.866	2014-12-16 08:06:54.866
59	SSV Reinickendorf	Reinicken.	SSR	1	2014-12-16 08:06:54.876	2014-12-16 08:06:54.876
60	SV Waldhof Mannheim	Mannheim	WaM	1	2014-12-16 08:06:54.889	2014-12-16 08:06:54.889
61	Preußen Bochum	Pr.Bochum	PrB	1	2014-12-16 08:06:54.898	2014-12-16 08:06:54.898
62	SG Union Solingen	Solingen	SGU	1	2014-12-16 08:06:54.909	2014-12-16 08:06:54.909
63	SV Babelsberg 03	Potsdam	SVB	1	2014-12-16 08:06:54.917	2014-12-16 08:06:54.917
64	Rot-Weiß Ahlen	Ahlen	RWA	1	2014-12-16 08:06:54.924	2014-12-16 08:06:54.924
65	BSV Kickers Emden	Emden	BSV	1	2014-12-16 08:06:54.934	2014-12-16 08:06:54.934
66	SC Charlottenburg	Charlot.	SCC	1	2014-12-16 08:06:54.944	2014-12-16 08:06:54.944
67	SC Jülich 1910	Jülich	SCJ	1	2014-12-16 08:06:54.95	2014-12-16 08:06:54.95
68	VfL Osnabrück	Osnabr.	Osn	1	2014-12-16 08:06:54.959	2014-12-16 08:06:54.959
69	FC St.Pauli	St.Pauli	StP	1	2014-12-16 08:06:54.966	2014-12-16 08:06:54.966
70	SV Wehen-Wiesbaden	Weh.Wbd.	WeW	1	2014-12-16 08:06:54.972	2014-12-16 08:06:54.972
71	FC Ingolstadt	Ingolst.	FCI	1	2014-12-16 08:06:54.979	2014-12-16 08:06:54.979
72	KSV Holstein Kiel	Kiel	Hol	1	2014-12-16 08:06:54.989	2014-12-16 08:06:54.989
73	SpVgg Unterhaching	Unterh.	SpU	1	2014-12-16 08:06:54.998	2014-12-16 08:06:54.998
74	SC Fortuna Köln	SCF Köln	SCK	1	2014-12-16 08:06:55.006	2014-12-16 08:06:55.006
75	VfR Aalen	Aalen	VfR	1	2014-12-16 08:06:55.013	2014-12-16 08:06:55.013
76	FC Sachsen Leipzig	S.Leipz.	SxL	1	2014-12-16 08:06:55.024	2014-12-16 08:06:55.024
77	Chemnitzer FC	Chemnitz	CFC	1	2014-12-16 08:06:55.03	2014-12-16 08:06:55.03
78	SpVgg Erkenschwick	Erkens.	SpE	1	2014-12-16 08:06:55.036	2014-12-16 08:06:55.036
79	SC Paderborn 07	Paderb.	SCP	1	2014-12-16 08:06:55.045	2014-12-16 08:06:55.045
80	FC Stahl Brandenburg	Stahl	StB	1	2014-12-16 08:06:55.052	2014-12-16 08:06:55.052
81	SpVgg Bayreuth	Bayreuth	SpB	1	2014-12-16 08:06:55.057	2014-12-16 08:06:55.057
82	VfB Oldenburg	Oldenb.	Old	1	2014-12-16 08:06:55.067	2014-12-16 08:06:55.067
83	FC 08 Homburg	Homburg	H08	1	2014-12-16 08:06:55.077	2014-12-16 08:06:55.077
84	VfR Neumünster	Neumüns.	Neu	1	2014-12-16 08:06:55.087	2014-12-16 08:06:55.087
85	SV Wilhelmshaven	Wilhelm.	Wil	1	2014-12-16 08:06:55.093	2014-12-16 08:06:55.093
86	TuS Xanten	Xanten	Xan	1	2014-12-16 08:06:55.102	2014-12-16 08:06:55.102
87	FC Heilbronn	Heilbronn	Hbr	1	2014-12-16 08:06:55.112	2014-12-16 08:06:55.112
88	FSV Zwickau	Zwickau	Zwi	1	2014-12-16 08:06:55.118	2014-12-16 08:06:55.118
89	Concordia Hamburg	Concord.	Con	1	2014-12-16 08:06:55.127	2014-12-16 08:06:55.127
90	1.FC Pforzheim	Pforzh.	FCP	1	2014-12-16 08:06:55.136	2014-12-16 08:06:55.136
91	SV Eintracht Trier	Trier	SVE	1	2014-12-16 08:06:55.142	2014-12-16 08:06:55.142
92	SpVgg Landshut	Landsh.	SpL	1	2014-12-16 08:06:55.152	2014-12-16 08:06:55.152
93	SpVgg Neuss	Neuss	SpN	1	2014-12-16 08:06:55.161	2014-12-16 08:06:55.161
94	OSC Bremerhaven	Bremerh.	OSC	1	2014-12-16 08:06:55.17	2014-12-16 08:06:55.17
95	Hammer SpVgg	Hamm	HSp	1	2014-12-16 08:06:55.177	2014-12-16 08:06:55.177
96	FC Stahl Eisenhüttenstadt	Eisenh.	StE	1	2014-12-16 08:06:55.187	2014-12-16 08:06:55.187
97	Würzburger Kickers	Würzburg	WKi	1	2014-12-16 08:06:55.196	2014-12-16 08:06:55.196
98	Dresdner SC	Dresd.SC	Dre	1	2014-12-16 08:06:55.202	2014-12-16 08:06:55.202
99	Bonner SC	Bonn	SCB	1	2014-12-16 08:06:55.211	2014-12-16 08:06:55.211
100	Viktoria Aschaffenburg	Aschaff.	VtA	1	2014-12-16 08:06:55.219	2014-12-16 08:06:55.219
101	VfR Wormatia Worms	Worms	WoW	1	2014-12-16 08:06:55.225	2014-12-16 08:06:55.225
102	SC Borussia Fulda	Fulda	Ful	1	2014-12-16 08:06:55.235	2014-12-16 08:06:55.235
103	VfB Fichte Bielefeld	Fichte	FBi	1	2014-12-16 08:06:55.245	2014-12-16 08:06:55.245
104	1.FC Passau	Passau	Pas	1	2014-12-16 08:06:55.255	2014-12-16 08:06:55.255
105	Hallescher FC	Halle	HFC	1	2014-12-16 08:06:55.262	2014-12-16 08:06:55.262
106	Wacker Burghausen	Wacker	WBu	1	2014-12-16 08:06:55.272	2014-12-16 08:06:55.272
107	1.FC Kleve	Kleve	Kle	1	2014-12-16 08:06:55.281	2014-12-16 08:06:55.281
108	1.FC Bocholt	Bocholt	Boc	1	2014-12-16 08:06:55.287	2014-12-16 08:06:55.287
109	SCB Viktoria Köln	Vik.Köln	VkK	1	2014-12-16 08:06:55.295	2014-12-16 08:06:55.295
110	Bremer SV	Brem.SV	Bre	1	2014-12-16 08:06:55.302	2014-12-16 08:06:55.302
111	SC 07 Idar-Oberstein	Idar-O.	IdO	1	2014-12-16 08:06:55.308	2014-12-16 08:06:55.308
112	FC Remscheid	Remsch.	FCR	1	2014-12-16 08:06:55.316	2014-12-16 08:06:55.316
113	VfB Langenfeld	Langenf.	Lfd	1	2014-12-16 08:06:55.325	2014-12-16 08:06:55.325
114	VfL Heidelberg-Kirchheim	Heidelb.	HKi	1	2014-12-16 08:06:55.335	2014-12-16 08:06:55.335
115	VfB Marburg	Marburg	Mar	1	2014-12-16 08:06:55.342	2014-12-16 08:06:55.342
116	TuS Mayen	Mayen	May	1	2014-12-16 08:06:55.351	2014-12-16 08:06:55.351
117	Rot-Weiß Lüdenscheid	Lüden.	RWL	1	2014-12-16 08:06:55.36	2014-12-16 08:06:55.36
118	FC Köln-Junkersdorf 1946	Junkers.	KJu	1	2014-12-16 08:06:55.366	2014-12-16 08:06:55.366
119	SC Verl	SC Verl	SCV	1	2014-12-16 08:06:55.372	2014-12-16 08:06:55.372
120	DSC Wanne-Eickel	Wanne-E.	WEi	1	2014-12-16 08:06:55.378	2014-12-16 08:06:55.378
121	SV Meppen	Meppen	SVM	1	2014-12-16 08:06:55.388	2014-12-16 08:06:55.388
122	VfB Peine	Peine	Pei	1	2014-12-16 08:06:55.396	2014-12-16 08:06:55.396
123	SC Viktoria Griesheim	Griesh.	VkG	1	2014-12-16 08:06:55.406	2014-12-16 08:06:55.406
124	SV Dessau	Dessau	Des	1	2014-12-16 08:06:55.415	2014-12-16 08:06:55.415
125	VfR Schleswig	Schlesw.	Slw	1	2014-12-16 08:06:55.42	2014-12-16 08:06:55.42
126	VfL Schwerte	Schwerte	Swt	1	2014-12-16 08:06:55.429	2014-12-16 08:06:55.429
\.


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dwiedenbruch
--

SELECT pg_catalog.setval('teams_id_seq', 126, true);


--
-- Name: appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: competitions_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY competitions
    ADD CONSTRAINT competitions_pkey PRIMARY KEY (id);


--
-- Name: competitions_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY competitions_teams
    ADD CONSTRAINT competitions_teams_pkey PRIMARY KEY (id);


--
-- Name: draws_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY draws
    ADD CONSTRAINT draws_pkey PRIMARY KEY (id);


--
-- Name: federations_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY federations
    ADD CONSTRAINT federations_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: matchdays_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY matchdays
    ADD CONSTRAINT matchdays_pkey PRIMARY KEY (id);


--
-- Name: points_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: index_games_on_guest_id; Type: INDEX; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE INDEX index_games_on_guest_id ON games USING btree (guest_id);


--
-- Name: index_games_on_home_id; Type: INDEX; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE INDEX index_games_on_home_id ON games USING btree (home_id);


--
-- Name: index_matchdays_on_number; Type: INDEX; Schema: public; Owner: dwiedenbruch; Tablespace: 
--

CREATE INDEX index_matchdays_on_number ON matchdays USING btree (number);


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

