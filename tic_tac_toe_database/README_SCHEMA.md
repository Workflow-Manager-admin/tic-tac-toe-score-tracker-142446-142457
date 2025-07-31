# Tic Tac Toe MySQL Database Schema

## Tables
- **users**: user_id, username, password_hash, created_at
- **games**: game_id, player_x_id, player_o_id, status, winner_id, created_at
- **moves**: move_id, game_id, player_id, move_number, row, col, created_at
- **scores**: user_id, wins, losses, draws

All foreign keys enforce referential integrity for user, game, and moves relationships.

## How to Initialize the Database

1. **Copy schema.sql into your MySQL container or use a client that can connect.**
2. **Run the schema file** with your MySQL credentials (see `db_connection.txt` for how to connect):

   ```bash
   mysql -u appuser -pdbuser123 -h localhost -P 5000 myapp < schema.sql
   ```

   This will:
   - Create the four tables with appropriate constraints and indexes.
   - Insert example users, initial scores, a finished sample game, and several moves.

3. **Check tables and test connection**, using client tools or the Node db_visualizer.

## Notes

- `wins`, `losses`, and `draws` in `scores` are integer counters for each user, updated by backend logic.
- `password_hash` should be a bcrypt or similar secure hash (here are placeholders for illustration).
- You can safely truncate the tables and/or modify the seed data before production use.
- To clear all data:  
  ```sql
  SET FOREIGN_KEY_CHECKS=0;
  TRUNCATE TABLE moves;
  TRUNCATE TABLE games;
  TRUNCATE TABLE scores;
  TRUNCATE TABLE users;
  SET FOREIGN_KEY_CHECKS=1;
  ```

- Changes to the schema may require a DB service restart or migration.

## Schema Version

- 2024-06-08, initial version for fullstack Tic Tac Toe.

