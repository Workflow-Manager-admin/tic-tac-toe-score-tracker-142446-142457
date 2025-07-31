-- Tic Tac Toe Database Schema
-- This file creates tables and (optionally) inserts example data for users, games, moves, and scores.

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- GAMES TABLE
CREATE TABLE IF NOT EXISTS games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    player_x_id INT NOT NULL,
    player_o_id INT NOT NULL,
    status ENUM('pending', 'active', 'completed', 'draw') NOT NULL DEFAULT 'pending',
    winner_id INT DEFAULT NULL, -- NULL if draw or not finished
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_x_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (player_o_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (winner_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- MOVES TABLE
CREATE TABLE IF NOT EXISTS moves (
    move_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    player_id INT NOT NULL,
    move_number INT NOT NULL,
    row TINYINT NOT NULL, -- 0, 1, or 2
    col TINYINT NOT NULL, -- 0, 1, or 2
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_game_move (game_id, move_number)
);

-- SCORES TABLE
CREATE TABLE IF NOT EXISTS scores (
    user_id INT PRIMARY KEY,
    wins INT NOT NULL DEFAULT 0,
    losses INT NOT NULL DEFAULT 0,
    draws INT NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Example Seed Data (You can copy/remove as needed)

-- Insert sample users
INSERT INTO users (username, password_hash) VALUES
  ('alice', '$2b$12$saltandhashforalice'),
  ('bob', '$2b$12$saltandhashforbob'),
  ('carol', '$2b$12$saltandhashforcarol');

-- Insert sample scores
INSERT INTO scores (user_id, wins, losses, draws) VALUES
  (1, 3, 2, 1),
  (2, 1, 4, 1),
  (3, 2, 2, 2);

-- Insert a sample game
INSERT INTO games (player_x_id, player_o_id, status, winner_id) VALUES
  (1, 2, 'completed', 1);

-- Insert sample moves for the game
INSERT INTO moves (game_id, player_id, move_number, row, col) VALUES
  (1, 1, 1, 0, 0),
  (1, 2, 2, 0, 1),
  (1, 1, 3, 1, 1),
  (1, 2, 4, 0, 2),
  (1, 1, 5, 2, 2); -- Alice (user 1) wins

-- Add more games/moves/scores as desired!
