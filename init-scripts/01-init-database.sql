-- ============================================================================
-- DATA1500 - Oppgavesett 1.3: Databaseadministrasjon
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
CREATE TABLE IF NOT EXISTS programmer (
    program_id SERIAL PRIMARY KEY,
    program_navn VARCHAR(100) NOT NULL UNIQUE,
    beskrivelse TEXT,
    opprettet TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS emner (
    emne_id SERIAL PRIMARY KEY,
    emne_kode VARCHAR(20) NOT NULL UNIQUE,
    emne_navn VARCHAR(100) NOT NULL,
    studiepoeng INT NOT NULL CHECK (studiepoeng > 0),
    beskrivelse TEXT,
    opprettet TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS studenter (
    student_id SERIAL PRIMARY KEY,
    fornavn VARCHAR(50) NOT NULL,
    etternavn VARCHAR(50) NOT NULL,
    epost VARCHAR(100) NOT NULL UNIQUE,
    program_id INT REFERENCES programmer(program_id),
    opprettet TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS emneregistreringer (
    registrering_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES studenter(student_id),
    emne_id INT NOT NULL REFERENCES emner(emne_id),
    semester VARCHAR(10) NOT NULL,
    karakter VARCHAR(2),
    registrert_dato TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(student_id, emne_id, semester)
);

-- Sett inn testdata
INSERT INTO programmer (program_navn, beskrivelse) VALUES
    ('Informatikk', 'Bachelor i Informatikk'),
    ('Data Science', 'Bachelor i Data Science'),
    ('Cybersikkerhet', 'Bachelor i Cybersikkerhet')
ON CONFLICT DO NOTHING;

INSERT INTO emner (emne_kode, emne_navn, studiepoeng, beskrivelse) VALUES
    ('DATA1500', 'Databaser', 10, 'Introduksjon til databaser og SQL'),
    ('DATA1100', 'Programmering', 10, 'Introduksjon til programmering'),
    ('DATA2200', 'Databasesystemer', 10, 'Avanserte databasekonsepter'),
    ('DATA3100', 'Distribuerte systemer', 10, 'Distribuerte databasesystemer')
ON CONFLICT DO NOTHING;

INSERT INTO studenter (fornavn, etternavn, epost, program_id) VALUES
    ('Ola', 'Nordmann', 'ola.nordmann@student.oslomet.no', 1),
    ('Kari', 'Normann', 'kari.normann@student.oslomet.no', 1),
    ('Per', 'Larsen', 'per.larsen@student.oslomet.no', 2),
    ('Anna', 'Johansen', 'anna.johansen@student.oslomet.no', 3)
ON CONFLICT DO NOTHING;

INSERT INTO emneregistreringer (student_id, emne_id, semester, karakter) VALUES
    (1, 1, '2024H', 'A'),
    (1, 2, '2024H', 'B'),
    (2, 1, '2024H', 'B'),
    (3, 3, '2024H', 'A'),
    (4, 4, '2024H', 'C')
ON CONFLICT DO NOTHING;

-- Opprett roller for tilgangsadministrasjon
CREATE ROLE admin_role LOGIN PASSWORD 'admin_pass';
CREATE ROLE foreleser_role LOGIN PASSWORD 'foreleser_pass';
CREATE ROLE student_role LOGIN PASSWORD 'student_pass';

-- Gi admin full tilgang
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

-- Gi foreleser lese- og skrive-tilgang
GRANT SELECT, INSERT, UPDATE ON programmer, emner, studenter, emneregistreringer TO foreleser_role;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO foreleser_role;

-- Gi student kun lese-tilgang
GRANT SELECT ON programmer, emner, studenter, emneregistreringer TO student_role;

-- Opprett en view for studenter (begrenset data)
CREATE VIEW student_view AS
SELECT 
    s.student_id,
    s.fornavn,
    s.etternavn,
    p.program_navn,
    e.emne_navn,
    er.karakter,
    er.semester
FROM studenter s
LEFT JOIN programmer p ON s.program_id = p.program_id
LEFT JOIN emneregistreringer er ON s.student_id = er.student_id
LEFT JOIN emner e ON er.emne_id = e.emne_id;

GRANT SELECT ON student_view TO student_role;

-- Opprett en view for foreleser (med alle detaljer)
CREATE VIEW foreleser_view AS
SELECT 
    s.student_id,
    s.fornavn,
    s.etternavn,
    s.epost,
    p.program_navn,
    e.emne_kode,
    e.emne_navn,
    er.karakter,
    er.semester
FROM studenter s
LEFT JOIN programmer p ON s.program_id = p.program_id
LEFT JOIN emneregistreringer er ON s.student_id = er.student_id
LEFT JOIN emner e ON er.emne_id = e.emne_id;

GRANT SELECT, INSERT, UPDATE ON foreleser_view TO foreleser_role;

-- Opprett indekser for ytelse
CREATE INDEX idx_studenter_program ON studenter(program_id);
CREATE INDEX idx_emneregistreringer_student ON emneregistreringer(student_id);
CREATE INDEX idx_emneregistreringer_emne ON emneregistreringer(emne_id);

-- Vis at initialisering er fullført
SELECT 'Database initialisert!' as status;
