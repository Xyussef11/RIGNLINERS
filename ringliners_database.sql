CREATE DATABASE IF NOT EXISTS yuseph;
USE yuseph;

-- Tabla para los jugadores
CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    score INT DEFAULT 0
);

-- Tabla para los juegos
CREATE TABLE IF NOT EXISTS games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Tabla para los equipos
CREATE TABLE IF NOT EXISTS teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla para las partidas entre jugadores
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT,
    player1_id INT,
    player2_id INT,
    winner_id INT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (player1_id) REFERENCES players(id),
    FOREIGN KEY (player2_id) REFERENCES players(id),
    FOREIGN KEY (winner_id) REFERENCES players(id)
);

-- Tabla para la asignación de jugadores a equipos
CREATE TABLE IF NOT EXISTS player_team (
    player_id INT,
    team_id INT,
    PRIMARY KEY (player_id, team_id),
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
);
