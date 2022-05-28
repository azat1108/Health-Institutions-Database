
--Script constains two Parts. Part 1 and Part 2 have to be executed separately. 
--Part 2 is rerunable. One can execute Part 2 as many times as he wants.

--Follow steps below:

--Step 1: Disconnect from database health_institutions if connected and close all sessions that are using this database
--Step 2: Execute Part 1
--Step 3: Connect to database health_institutions
--Step 4: Execute Part 2



--Part 1
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

DROP DATABASE IF EXISTS health_institutions;
--
-- Name: health_institutions; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE health_institutions WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE health_institutions OWNER TO postgres;



--connect to health_institutions;


--Part 2
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

SET default_table_access_method = heap;


DROP TABLE IF EXISTS public.appointments;
DROP TABLE IF EXISTS public.patients;
DROP TABLE IF EXISTS public.services;
DROP TABLE IF EXISTS public.employees;
DROP TABLE IF EXISTS public.positions;
DROP TABLE IF EXISTS public.institutions;
DROP TABLE IF EXISTS public.addresses;
DROP TABLE IF EXISTS public.streets;
DROP TABLE IF EXISTS public.districts;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE IF NOT EXISTS public.addresses (
    address_id integer NOT NULL,
    street_id integer NOT NULL,
    building_number integer NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.addresses ALTER COLUMN address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.addresses_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.appointments (
    appointment_id integer NOT NULL,
    patient_id integer NOT NULL,
    service_id integer NOT NULL,
    employee_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.appointments ALTER COLUMN appointment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.appointments_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.districts (
    district_id integer NOT NULL,
    district_name character varying(30) NOT NULL
);


ALTER TABLE public.districts OWNER TO postgres;

--
-- Name: districts_district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.districts ALTER COLUMN district_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.districts_district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.employees (
    employee_id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    second_name character varying(30) NOT NULL,
    mobile character varying(11) NOT NULL,
    institution_id integer NOT NULL,
    position_id integer NOT NULL,
    birthday date,
    salary integer NOT NULL,
    CONSTRAINT employees_salary_check CHECK ((salary > 0)),
    CONSTRAINT employees_birthday_check CHECK ((EXTRACT(year FROM birthday) > (1900)::numeric))
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employees ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employees_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: institutions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.institutions (
    institution_id integer NOT NULL,
    institution_name character varying(30) NOT NULL,
    capacity integer NOT NULL,
    address_id integer NOT NULL,
    CONSTRAINT institutions_capacity_check CHECK ((capacity > 0))
);


ALTER TABLE public.institutions OWNER TO postgres;

--
-- Name: institutions_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.institutions ALTER COLUMN institution_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.institutions_institution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.patients (
    patient_id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    second_name character varying(30) NOT NULL,
    mobile character varying(11) NOT NULL,
    insurance_number character(10),
    birthday date NOT NULL,
    added_date date DEFAULT now() NOT NULL,
    email character varying(30) NOT NULL,
    CONSTRAINT patients_birthday_check CHECK ((EXTRACT(year FROM birthday) > (1900)::numeric)),
    CONSTRAINT patients_email_check CHECK (((email)::text ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text))
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.patients ALTER COLUMN patient_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.patients_patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.positions (
    position_id integer NOT NULL,
    title character varying(30) NOT NULL,
    bonus integer,
    CONSTRAINT positions_bonus_check CHECK ((bonus > 0))
);

ALTER TABLE public.positions OWNER TO postgres;

--
-- Name: positions_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.positions ALTER COLUMN position_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.positions_position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.services (
    service_id integer NOT NULL,
    service_name character varying(30) NOT NULL,
    price integer NOT NULL,
    CONSTRAINT services_price_check CHECK ((price > 0))
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.services ALTER COLUMN service_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.services_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE  IF NOT EXISTS public.streets (
    street_id integer NOT NULL,
    street_name character varying(30) NOT NULL,
    district_id integer NOT NULL
);


ALTER TABLE public.streets OWNER TO postgres;

--
-- Name: streets_street_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.streets ALTER COLUMN street_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.streets_street_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


---
--
-- Name: addresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_address_id_seq', 1, false);


--
-- Name: appointments_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 1, false);


--
-- Name: districts_district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.districts_district_id_seq', 1, false);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 1, false);


--
-- Name: institutions_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.institutions_institution_id_seq', 1, false);


--
-- Name: patients_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patients_patient_id_seq', 1, false);


--
-- Name: positions_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_position_id_seq', 1, false);


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_service_id_seq', 1, false);


--
-- Name: streets_street_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.streets_street_id_seq', 1, false);



---
--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (address_id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: districts districts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (district_id);


--
-- Name: employees employees_mobile_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_mobile_key UNIQUE (mobile);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: institutions institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (institution_id);


--
-- Name: patients patients_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_email_key UNIQUE (email);


--
-- Name: patients patients_insurance_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_insurance_number_key UNIQUE (insurance_number);

--
-- Name: districts districts_district_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_district_name_key UNIQUE (district_name);


--
-- Name: streets streets_street_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);


--
-- Name: patients patients_mobile_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_mobile_key UNIQUE (mobile);


--
-- Name: insitutions insitutions_insitution_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT insitutions_insitution_name_key UNIQUE (institution_name);



--
-- Name: positions insitutions_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT insitutions_title_key UNIQUE (title);




--
-- Name: services services_service_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_service_name_key UNIQUE (service_name);



--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (position_id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: streets streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);


--
-- Name: addresses addresses_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(street_id);


--
-- Name: appointments appointments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: appointments appointments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);


--
-- Name: employees employees_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(institution_id);


--
-- Name: employees employees_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.positions(position_id);


--
-- Name: institutions institutions_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(address_id);


--
-- Name: streets streets_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.districts(district_id);



--
-- Name: appointments appointments_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);



--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patients(first_name,second_name,mobile,insurance_number,birthday,added_date,email) 
(SELECT * FROM 
(VALUES ('ADAM','SANDLER','87771112233','1111111111',TO_DATE('1975-01-01','YYYY-MM-DD'),TO_DATE('2020-01-01','YYYY-MM-DD'),'ADAM.SANDLER@GMAIL.COM'),
('ADAM','HOLLAND','87772223344','2222222222',TO_DATE('1985-01-01','YYYY-MM-DD'),TO_DATE('2019-01-01','YYYY-MM-DD'),'ADAM.HOLLAND@GMAIL.COM'),
('TIM','HOLLAND','87773334455','3333333333',TO_DATE('1986-01-01','YYYY-MM-DD'),TO_DATE('2018-01-01','YYYY-MM-DD'),'TIM.HOLLAND@GMAIL.COM'),
('TIM','BURTON','87774445566','4444444444',TO_DATE('1987-01-01','YYYY-MM-DD'),TO_DATE('2017-01-01','YYYY-MM-DD'),'TIM.BURTON@GMAIL.COM'),
('HENRY','BURTON','87775556677','5555555555',TO_DATE('1988-01-01','YYYY-MM-DD'),TO_DATE('2016-01-01','YYYY-MM-DD'),'HENRY.BURTON@GMAIL.COM')) 
AS tmp(first_name,second_name,mobile,insurance_number,birthday,added_date,email) 
WHERE NOT EXISTS(SELECT 1 FROM public.patients p WHERE p.first_name=tmp.first_name AND p.second_name=tmp.second_name))
ON CONFLICT(mobile) DO NOTHING;

--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.services(service_name,price) 
VALUES('ANESTHESIOLOGY',1000), ('CARDIAC SURGERY',2000),('DERMATOLOGY',3000),('DIALYSIS',4000),('ENDOCRINOLOGY',5000)
ON CONFLICT(service_name) DO NOTHING;


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.districts(district_name) 
VALUES('FUNT PLACE'),('WAIP MARKET'),('ROBRIN HILL'),('HOMAILP CROSS'),('CREETET PLAZA')
ON CONFLICT(district_name) DO NOTHING;


--
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.streets(street_name,district_id) 
VALUES('HERITAGE AVENUE',(SELECT district_id FROM public.districts WHERE district_name='FUNT PLACE')),
('GRAY PASSAGE',(SELECT district_id FROM public.districts WHERE district_name='WAIP MARKET')),
('CASTLE ROW',(SELECT district_id FROM public.districts WHERE district_name='ROBRIN HILL')),
('VALLEY ROUTE',(SELECT district_id FROM public.districts WHERE district_name='HOMAILP CROSS')),
('OLIVE STREET',(SELECT district_id FROM public.districts WHERE district_name='CREETET PLAZA'))
ON CONFLICT(street_name) DO NOTHING;

--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.addresses(street_id,building_number) 
(SELECT * FROM (
VALUES ((SELECT street_id FROM public.streets WHERE street_name='HERITAGE AVENUE'),1),
((SELECT street_id FROM public.streets WHERE street_name='GRAY PASSAGE'),2),
((SELECT street_id FROM public.streets WHERE street_name='CASTLE ROW'),3),
((SELECT street_id FROM public.streets WHERE street_name='VALLEY ROUTE'),4),
((SELECT street_id FROM public.streets WHERE street_name='OLIVE STREET'),5)) 
AS tmp(street_id,building_number) 
WHERE NOT EXISTS(SELECT 1 FROM public.addresses a WHERE a.street_id=tmp.street_id AND a.building_number=tmp.building_number));


--
-- Data for Name: institutions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.institutions(institution_name,capacity,address_id) 
VALUES('INSTITUTION 1',100,(SELECT address_id FROM public.addresses a JOIN public.streets s ON a.street_id=s.street_id WHERE s.street_name='HERITAGE AVENUE' AND a.building_number=1)),
('INSTITUTION 2',100,(SELECT address_id FROM public.addresses a JOIN public.streets s ON a.street_id=s.street_id WHERE s.street_name='GRAY PASSAGE' AND a.building_number=2)),
('INSTITUTION 3',100,(SELECT address_id FROM public.addresses a JOIN public.streets s ON a.street_id=s.street_id WHERE s.street_name='CASTLE ROW' AND a.building_number=3)),
('INSTITUTION 4',100,(SELECT address_id FROM public.addresses a JOIN public.streets s ON a.street_id=s.street_id WHERE s.street_name='VALLEY ROUTE' AND a.building_number=4)),
('INSTITUTION 5',100,(SELECT address_id FROM public.addresses a JOIN public.streets s ON a.street_id=s.street_id WHERE s.street_name='OLIVE STREET' AND a.building_number=5))
ON CONFLICT(institution_name) DO NOTHING;


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.positions(title,bonus) 
VALUES('SECURITY',1000),
('NURSE',2000),
('HEAD NURSE',3000),
('DOCTOR',4000),
('HEAD DOCTOR',5000)
ON CONFLICT(title) DO NOTHING;


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees(first_name,second_name,mobile,institution_id,position_id,birthday,salary) 
(SELECT * FROM (
VALUES ('ANNA','CARTER','87776667788',(SELECT institution_id FROM public.institutions WHERE institution_name='INSTITUTION 1'),(SELECT position_id FROM public.positions WHERE title='DOCTOR'),TO_DATE('1985-01-01','YYYY-MM-DD'),10000),
('DONNA','CAGE','87777778899',(SELECT institution_id FROM public.institutions WHERE institution_name='INSTITUTION 2'),(SELECT position_id FROM public.positions WHERE title='DOCTOR'),TO_DATE('1986-01-01','YYYY-MM-DD'),20000),
('HELGA','TORI','87778889911',(SELECT institution_id FROM public.institutions WHERE institution_name='INSTITUTION 3'),(SELECT position_id FROM public.positions WHERE title='DOCTOR'),TO_DATE('1987-01-01','YYYY-MM-DD'),30000),
('AMANDA','CERNEY','87779991122',(SELECT institution_id FROM public.institutions WHERE institution_name='INSTITUTION 4'),(SELECT position_id FROM public.positions WHERE title='DOCTOR'),TO_DATE('1988-01-01','YYYY-MM-DD'),40000),
('TRACY','GUN','87771113344',(SELECT institution_id FROM public.institutions WHERE institution_name='INSTITUTION 5'),(SELECT position_id FROM public.positions WHERE title='DOCTOR'),TO_DATE('1989-01-01','YYYY-MM-DD'),50000)) 
AS tmp(first_name,second_name,mobile,institution_id,position_id,birthday) 
WHERE NOT EXISTS(SELECT 1 FROM public.employees e WHERE e.first_name=tmp.first_name AND e.second_name=tmp.second_name))
ON CONFLICT(mobile) DO NOTHING;

--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.appointments(patient_id,service_id,employee_id,start_time) 
(SELECT * FROM(
VALUES ((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'SANDLER'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-20 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'SANDLER'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-22 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-21 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-24 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-23 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-03-25 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'BURTON'),(SELECT service_id FROM public.services s WHERE s.service_name = 'DERMATOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'DONNA' AND e.second_name = 'CAGE'),TO_TIMESTAMP('2022-04-17 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'HENRY' AND p.second_name = 'BURTON'),(SELECT service_id FROM public.services s WHERE s.service_name = 'DERMATOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'DONNA' AND e.second_name = 'CAGE'),TO_TIMESTAMP('2022-04-18 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'SANDLER'),(SELECT service_id FROM public.services s WHERE s.service_name = 'DIALYSIS'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'AMANDA' AND e.second_name = 'CERNEY'),TO_TIMESTAMP('2022-05-17 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'SANDLER'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-02-22 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-02-21 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-02-24 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-02-23 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'HOLLAND'),(SELECT service_id FROM public.services s WHERE s.service_name = 'ANESTHESIOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'ANNA' AND e.second_name = 'CARTER'),TO_TIMESTAMP('2022-02-25 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'TIM' AND p.second_name = 'BURTON'),(SELECT service_id FROM public.services s WHERE s.service_name = 'DERMATOLOGY'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'DONNA' AND e.second_name = 'CAGE'),TO_TIMESTAMP('2022-03-17 9:00:00','YYYY-MM-DD HH:MI:SS')),
((SELECT patient_id FROM public.patients p WHERE p.first_name = 'ADAM' AND p.second_name = 'SANDLER'),(SELECT service_id FROM public.services s WHERE s.service_name = 'DIALYSIS'),(SELECT employee_id FROM public.employees e WHERE e.first_name = 'AMANDA' AND e.second_name = 'CERNEY'),TO_TIMESTAMP('2022-04-17 9:00:00','YYYY-MM-DD HH:MI:SS'))) 
AS tmp(patient_id,service_id,employee_id,start_time) 
WHERE NOT EXISTS(SELECT 1 FROM public.appointments a WHERE a.patient_id=tmp.patient_id AND a.start_time=tmp.start_time));

--
-- Query  to identify doctors with insufficient workload (less than 5 patients a month for the past 3 months)
--

WITH tmp AS (SELECT
    COUNT(APPOINTMENT_ID) appointments_number,
    E.FIRST_NAME,
    E.SECOND_NAME,
    extract(month from A.START_TIME) month_number
FROM
    PUBLIC.APPOINTMENTS A
JOIN PUBLIC.EMPLOYEES E
ON
    A.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE
    EXTRACT(MONTH
FROM
    A.START_TIME)>EXTRACT(MONTH
FROM
    (NOW()-INTERVAL '90 DAYS'))
GROUP BY
    A.EMPLOYEE_ID,
    E.FIRST_NAME,
    E.SECOND_NAME,
    EXTRACT(MONTH FROM A.START_TIME)
ORDER BY e.first_name, month_number)
SELECT AVG(appointments_number) average_appointments_per_month,first_name,second_name
FROM tmp
GROUP BY first_name,second_name
HAVING AVG(appointments_number)<5;