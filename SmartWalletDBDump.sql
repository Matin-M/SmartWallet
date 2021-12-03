--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

--
-- Name: bankaccount; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.bankaccount (
    accountid character(100) NOT NULL,
    accountname character(100),
    funds double precision
);


ALTER TABLE public.bankaccount OWNER TO matinmassoudi;

--
-- Name: contactinfo; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.contactinfo (
    contactid character(100) NOT NULL,
    name character(100),
    phonenumber bigint,
    address character(100)
);


ALTER TABLE public.contactinfo OWNER TO matinmassoudi;

--
-- Name: contains; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.contains (
    accountid character(100) NOT NULL,
    transactionid character(100) NOT NULL
);


ALTER TABLE public.contains OWNER TO matinmassoudi;

--
-- Name: has; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.has (
    userid character(100) NOT NULL,
    contactid character(100)
);


ALTER TABLE public.has OWNER TO matinmassoudi;

--
-- Name: owns; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.owns (
    userid character(100) NOT NULL,
    accountid character(100) NOT NULL
);


ALTER TABLE public.owns OWNER TO matinmassoudi;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.transaction (
    transactionid character(100) NOT NULL,
    title character(100),
    date date,
    amount double precision,
    category character(100)
);


ALTER TABLE public.transaction OWNER TO matinmassoudi;

--
-- Name: users; Type: TABLE; Schema: public; Owner: matinmassoudi
--

CREATE TABLE public.users (
    userid character(100) NOT NULL,
    email character(100),
    passwd character(100)
);


ALTER TABLE public.users OWNER TO matinmassoudi;

--
-- Data for Name: bankaccount; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.bankaccount (accountid, accountname, funds) FROM stdin;
0011                                                                                                	Ones Checking                                                                                       	111.11
0012                                                                                                	Twos Checking                                                                                       	22.22
0022                                                                                                	Twos Savings                                                                                        	222.22
0013                                                                                                	Threes Checking                                                                                     	333.33
0023                                                                                                	Threes Savings                                                                                      	3333.33
0033                                                                                                	Threes Venmo                                                                                        	3.33
0014                                                                                                	Fours Checking                                                                                      	444.44
0024                                                                                                	Fours Savings                                                                                       	4.44
0034                                                                                                	Fours Venmo                                                                                         	4444.44
0044                                                                                                	Fours Cash                                                                                          	444.44
\.


--
-- Data for Name: contactinfo; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.contactinfo (contactid, name, phonenumber, address) FROM stdin;
02                                                                                                  	Test Two                                                                                            	2222222222	222 N 2 St                                                                                          
03                                                                                                  	Test Three                                                                                          	3333333333	333 N 3 St                                                                                          
wAQ0n                                                                                               	lkjsdf                                                                                              	123123	sdfsf                                                                                               
\.


--
-- Data for Name: contains; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.contains (accountid, transactionid) FROM stdin;
0011                                                                                                	110000                                                                                              
0011                                                                                                	110001                                                                                              
0011                                                                                                	110002                                                                                              
0011                                                                                                	110003                                                                                              
0011                                                                                                	110004                                                                                              
0011                                                                                                	110005                                                                                              
0011                                                                                                	110006                                                                                              
0011                                                                                                	110008                                                                                              
0011                                                                                                	110009                                                                                              
0012                                                                                                	210010                                                                                              
0012                                                                                                	210011                                                                                              
0012                                                                                                	210012                                                                                              
0012                                                                                                	210013                                                                                              
0012                                                                                                	210014                                                                                              
0012                                                                                                	210015                                                                                              
0012                                                                                                	210016                                                                                              
0012                                                                                                	210017                                                                                              
0012                                                                                                	210018                                                                                              
0022                                                                                                	220019                                                                                              
0022                                                                                                	220020                                                                                              
0022                                                                                                	220021                                                                                              
0022                                                                                                	220022                                                                                              
0022                                                                                                	220023                                                                                              
0022                                                                                                	220024                                                                                              
0022                                                                                                	220025                                                                                              
0022                                                                                                	220026                                                                                              
0013                                                                                                	310027                                                                                              
0013                                                                                                	310028                                                                                              
0013                                                                                                	310029                                                                                              
0013                                                                                                	310030                                                                                              
0013                                                                                                	310031                                                                                              
0013                                                                                                	310032                                                                                              
0013                                                                                                	310033                                                                                              
0023                                                                                                	320034                                                                                              
0023                                                                                                	320035                                                                                              
0023                                                                                                	320036                                                                                              
0023                                                                                                	320037                                                                                              
0023                                                                                                	320038                                                                                              
0023                                                                                                	320039                                                                                              
0033                                                                                                	330040                                                                                              
0033                                                                                                	330041                                                                                              
0033                                                                                                	330042                                                                                              
0033                                                                                                	330043                                                                                              
0033                                                                                                	330044                                                                                              
0014                                                                                                	410045                                                                                              
0014                                                                                                	410046                                                                                              
0014                                                                                                	410047                                                                                              
0014                                                                                                	410048                                                                                              
0024                                                                                                	420049                                                                                              
0024                                                                                                	420050                                                                                              
0024                                                                                                	420051                                                                                              
0034                                                                                                	430052                                                                                              
0034                                                                                                	430053                                                                                              
0044                                                                                                	440054                                                                                              
\.


--
-- Data for Name: has; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.has (userid, contactid) FROM stdin;
2                                                                                                   	02                                                                                                  
3                                                                                                   	03                                                                                                  
QecCx                                                                                               	wAQ0n                                                                                               
\.


--
-- Data for Name: owns; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.owns (userid, accountid) FROM stdin;
1                                                                                                   	0011                                                                                                
2                                                                                                   	0012                                                                                                
2                                                                                                   	0022                                                                                                
3                                                                                                   	0013                                                                                                
3                                                                                                   	0023                                                                                                
3                                                                                                   	0033                                                                                                
4                                                                                                   	0014                                                                                                
4                                                                                                   	0024                                                                                                
4                                                                                                   	0034                                                                                                
4                                                                                                   	0044                                                                                                
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.transaction (transactionid, title, date, amount, category) FROM stdin;
110000                                                                                              	TACO BELL                                                                                           	2021-10-30	13.45	Food                                                                                                
110001                                                                                              	DOMINOS                                                                                             	2021-10-10	24.31	Food                                                                                                
110002                                                                                              	CHEVRON GAS                                                                                         	2021-10-12	33.45	Other                                                                                               
110003                                                                                              	AMAZON PURCHASE                                                                                     	2021-10-11	79.82	Online                                                                                              
110004                                                                                              	SOUND SPEAKER                                                                                       	2021-04-12	312.45	Online                                                                                              
110005                                                                                              	STEAM PURCHASE                                                                                      	2021-08-15	31.52	Online                                                                                              
110006                                                                                              	COCA COLA VENDING                                                                                   	2021-02-14	3	Food                                                                                                
110008                                                                                              	UBER                                                                                                	2021-07-21	9.87	Other                                                                                               
110009                                                                                              	SWIFT                                                                                               	2020-12-14	31.45	Other                                                                                               
210010                                                                                              	FRYS FOOD                                                                                           	2021-05-12	95.15	Grocery                                                                                             
210011                                                                                              	NETFLIX                                                                                             	2021-09-07	9.99	Online                                                                                              
210012                                                                                              	DISNEY PLUS                                                                                         	2021-06-30	9.99	Online                                                                                              
210013                                                                                              	SONIC DRIVE IN                                                                                      	2021-02-02	12.34	Food                                                                                                
210014                                                                                              	WALMART                                                                                             	2021-04-18	48.25	Grocery                                                                                             
210015                                                                                              	GLACIER WATER                                                                                       	2021-04-21	1.25	Food                                                                                                
210016                                                                                              	INFINITY                                                                                            	2021-05-12	9.65	Online                                                                                              
210017                                                                                              	TOYOTA                                                                                              	2021-06-17	31234.45	Other                                                                                               
210018                                                                                              	TACO BELL                                                                                           	2021-03-12	12.45	Food                                                                                                
220019                                                                                              	AOD FOEDS                                                                                           	2021-08-02	31.72	Online                                                                                              
220020                                                                                              	SAFEWAY                                                                                             	2021-09-13	202.66	Grocery                                                                                             
220021                                                                                              	BURGER KING                                                                                         	2021-05-16	13.31	Food                                                                                                
220022                                                                                              	AMAZON                                                                                              	2021-01-21	92.56	Online                                                                                              
220023                                                                                              	AMAZON                                                                                              	2021-01-30	12.33	Online                                                                                              
220024                                                                                              	MCDONALDS                                                                                           	2021-10-27	11.17	Food                                                                                                
220025                                                                                              	TACO BELL                                                                                           	2021-10-30	13.45	Food                                                                                                
220026                                                                                              	MCDONALDS                                                                                           	2021-10-27	11.17	Food                                                                                                
310027                                                                                              	DOMINOS                                                                                             	2021-10-10	24.31	Food                                                                                                
310028                                                                                              	CHEVRON GAS                                                                                         	2021-10-12	33.45	Other                                                                                               
310029                                                                                              	AMAZON PURCHASE                                                                                     	2021-10-11	79.82	Online                                                                                              
310030                                                                                              	SOUND SPEAKER                                                                                       	2021-04-12	312.45	Online                                                                                              
310031                                                                                              	STEAM PURCHASE                                                                                      	2021-08-15	31.52	Online                                                                                              
310032                                                                                              	COCA COLA VENDING                                                                                   	2021-02-14	3	Food                                                                                                
310033                                                                                              	QDOBA EATS                                                                                          	2021-01-14	18.95	Food                                                                                                
320034                                                                                              	UBER                                                                                                	2021-07-21	9.87	Other                                                                                               
320035                                                                                              	SWIFT                                                                                               	2020-12-14	31.45	Other                                                                                               
320036                                                                                              	FRYS FOOD                                                                                           	2021-05-12	95.15	Grocery                                                                                             
320037                                                                                              	NETFLIX                                                                                             	2021-09-07	9.99	Online                                                                                              
320038                                                                                              	DISNEY PLUS                                                                                         	2021-06-30	9.99	Online                                                                                              
320039                                                                                              	SONIC DRIVE IN                                                                                      	2021-02-02	12.34	Food                                                                                                
330040                                                                                              	WALMART                                                                                             	2021-04-18	48.25	Grocery                                                                                             
330041                                                                                              	GLACIER WATER                                                                                       	2021-04-21	1.25	Food                                                                                                
330042                                                                                              	INFINITY                                                                                            	2021-05-12	9.65	Online                                                                                              
330043                                                                                              	TOYOTA                                                                                              	2021-06-17	31234.45	Other                                                                                               
330044                                                                                              	TACO BELL                                                                                           	2021-03-12	12.45	Food                                                                                                
410045                                                                                              	AOD FOEDS                                                                                           	2021-08-02	31.72	Online                                                                                              
410046                                                                                              	SAFEWAY                                                                                             	2021-09-13	202.66	Grocery                                                                                             
410047                                                                                              	BURGER KING                                                                                         	2021-05-16	13.31	Food                                                                                                
410048                                                                                              	AMAZON                                                                                              	2021-01-21	92.56	Online                                                                                              
420049                                                                                              	AMAZON                                                                                              	2021-01-30	12.33	Online                                                                                              
420050                                                                                              	MCDONALDS                                                                                           	2021-10-27	11.17	Food                                                                                                
420051                                                                                              	SAFEWAY                                                                                             	2021-09-13	202.66	Grocery                                                                                             
430052                                                                                              	BURGER KING                                                                                         	2021-05-16	13.31	Food                                                                                                
430053                                                                                              	AMAZON                                                                                              	2021-01-21	92.56	Online                                                                                              
440054                                                                                              	AMAZON                                                                                              	2021-01-30	12.33	Online                                                                                              
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: matinmassoudi
--

COPY public.users (userid, email, passwd) FROM stdin;
1                                                                                                   	1@test.com                                                                                          	pwd1                                                                                                
2                                                                                                   	2@test.com                                                                                          	pwd2                                                                                                
3                                                                                                   	3@test.com                                                                                          	pwd3                                                                                                
4                                                                                                   	4@test.com                                                                                          	pwd4                                                                                                
iN3ZZ                                                                                               	matin@massoudi.net                                                                                  	test1                                                                                               
QecCx                                                                                               	newiosuser@gmail.com                                                                                	testpassword                                                                                        
\.


--
-- Name: bankaccount bankaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.bankaccount
    ADD CONSTRAINT bankaccount_pkey PRIMARY KEY (accountid);


--
-- Name: contactinfo contactinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.contactinfo
    ADD CONSTRAINT contactinfo_pkey PRIMARY KEY (contactid);


--
-- Name: contains contains_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT contains_pkey PRIMARY KEY (accountid, transactionid);


--
-- Name: has has_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_pkey PRIMARY KEY (userid);


--
-- Name: owns owns_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_pkey PRIMARY KEY (userid, accountid);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transactionid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: contains contains_accountid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT contains_accountid_fkey FOREIGN KEY (accountid) REFERENCES public.bankaccount(accountid) ON DELETE CASCADE;


--
-- Name: contains contains_transactionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.contains
    ADD CONSTRAINT contains_transactionid_fkey FOREIGN KEY (transactionid) REFERENCES public.transaction(transactionid) ON DELETE CASCADE;


--
-- Name: has has_contactid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_contactid_fkey FOREIGN KEY (contactid) REFERENCES public.contactinfo(contactid) ON DELETE CASCADE;


--
-- Name: has has_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.has
    ADD CONSTRAINT has_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: owns owns_accountid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_accountid_fkey FOREIGN KEY (accountid) REFERENCES public.bankaccount(accountid) ON DELETE CASCADE;


--
-- Name: owns owns_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matinmassoudi
--

ALTER TABLE ONLY public.owns
    ADD CONSTRAINT owns_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

