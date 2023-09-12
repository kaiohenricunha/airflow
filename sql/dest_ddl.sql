CREATE TABLE bus_data (
    ordem VARCHAR(10),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    datahora BIGINT,
    velocidade INT,
    linha VARCHAR(10),
    datahoraenvio BIGINT,
    datahoraservidor BIGINT,
    day DATE,
    PRIMARY KEY (ordem, day)
);
