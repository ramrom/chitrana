--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: charts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE charts (
    chart_id integer NOT NULL,
    column_name1 character varying(32),
    column_name3 integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: charts_chart_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE charts_chart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charts_chart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE charts_chart_id_seq OWNED BY charts.chart_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: chart_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY charts ALTER COLUMN chart_id SET DEFAULT nextval('charts_chart_id_seq'::regclass);


--
-- Name: charts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY charts
    ADD CONSTRAINT charts_pkey PRIMARY KEY (chart_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO chitrana, public;

INSERT INTO schema_migrations (version) VALUES ('20160907235917');

