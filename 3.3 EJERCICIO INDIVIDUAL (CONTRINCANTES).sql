-- Creación de la tabla CONTRINCANTES
CREATE TABLE CONTRINCANTES (
    IDContrincante INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NombreUsuarioContrincante VARCHAR(255) NOT NULL,
    VecesJugado INTEGER NOT NULL,
    EsAmigo BOOLEAN NOT NULL
) ENGINE = InnoDB;

-- Inserción de valores en la tabla CONTRINCANTES
INSERT INTO CONTRINCANTES (NombreUsuarioContrincante, VecesJugado, EsAmigo)
VALUES
    ('DragonMaster', 10, true),
    ('ShadowNinja', 5, false),
    ('MagicGamer', 8, true);

-- Creación de la tabla Partida
CREATE TABLE Partida (
    Identificador INTEGER PRIMARY KEY NOT NULL,
    FechaHoraTerminacion DATETIME NOT NULL,
    Duracion INTEGER NOT NULL,
    Ganador VARCHAR(255) NOT NULL
) ENGINE = InnoDB;

-- Inserción de valores en la tabla Partida
INSERT INTO Partida (Identificador, FechaHoraTerminacion, Duracion, Ganador)
VALUES
    (1, '2024-03-01 14:30:00', 30, 'DragonMaster'),
    (2, '2024-03-02 16:45:00', 45, 'MagicGamer');

-- Creación de la tabla ParticipacionContrincantes
CREATE TABLE ParticipacionContrincantes (
    IDContrincante INTEGER NOT NULL,
    Partida INTEGER NOT NULL,
    Posicion INTEGER NOT NULL,
    PRIMARY KEY (IDContrincante, Partida),
    FOREIGN KEY (IDContrincante) REFERENCES CONTRINCANTES(IDContrincante),
    FOREIGN KEY (Partida) REFERENCES Partida(Identificador)
) ENGINE = InnoDB;

-- Inserción de valores en la tabla ParticipacionContrincantes
INSERT INTO ParticipacionContrincantes (IDContrincante, Partida, Posicion)
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 1, 3),
    (1, 2, 2),
    (3, 2, 1);

-- Creación de la tabla HistorialPartidas
CREATE TABLE HistorialPartidas (
    IDHistorial INTEGER PRIMARY KEY AUTO_INCREMENT,
    IDContrincante1 INTEGER NOT NULL,
    IDContrincante2 INTEGER NOT NULL,
    Resultado VARCHAR(50) NOT NULL,
    FechaJuego DATETIME NOT NULL,
    Duracion INTEGER NOT NULL,
    FOREIGN KEY (IDContrincante1) REFERENCES CONTRINCANTES(IDContrincante),
    FOREIGN KEY (IDContrincante2) REFERENCES CONTRINCANTES(IDContrincante)
) ENGINE = InnoDB;

-- Inserción de valores en la tabla HistorialPartidas
INSERT INTO HistorialPartidas (IDContrincante1, IDContrincante2, Resultado, FechaJuego, Duracion)
VALUES
    (1, 2, 'Ganó Contrincante1', '2024-03-01 14:00:00', 20),
    (3, 1, 'Empate', '2024-03-02 16:30:00', 25),
    (2, 3, 'Ganó Contrincante3', '2024-03-03 12:45:00', 15);

--Esta consulta selecciona las partidas en las que ha participado 'DragonMaster' y que también incluyen participación de 'MagicGamer'.

SELECT p.Partida
FROM CONTRINCANTES c1
JOIN ParticipacionContrincantes p ON c1.IDContrincante = p.IDContrincante
WHERE c1.NombreUsuarioContrincante = 'DragonMaster'
  AND p.Partida IN (
    SELECT p2.Partida
    FROM CONTRINCANTES c2
    JOIN ParticipacionContrincantes p2 ON c2.IDContrincante = p2.IDContrincante
    WHERE c2.NombreUsuarioContrincante = 'MagicGamer'
  );


--consulta que selecciona las partidas en las que ha participado 'DragonMaster' y también muestra la información sobre esas partidas

SELECT p.Partida, p.Posicion, p.IDContrincante, c.NombreUsuarioContrincante, c.VecesJugado, c.EsAmigo
FROM CONTRINCANTES c
JOIN ParticipacionContrincantes p ON c.IDContrincante = p.IDContrincante
WHERE c.NombreUsuarioContrincante = 'DragonMaster';

