// =============================================================================
// DATABASE CONFIGURATION FOR RAILWAY
// =============================================================================
// Railway provides DATABASE_URL automatically when you add PostgreSQL

const path = require("path");
const { parse } = require("pg-connection-string");

module.exports = ({ env }) => {
  // Check if DATABASE_URL exists (Railway provides this)
  const databaseUrl = env("DATABASE_URL");

  if (databaseUrl) {
    // Parse the connection string from Railway
    const config = parse(databaseUrl);

    return {
      connection: {
        client: "postgres",
        connection: {
          host: config.host,
          port: config.port,
          database: config.database,
          user: config.user,
          password: config.password,
          ssl: {
            rejectUnauthorized: false, // Required for Railway
          },
        },
        pool: {
          min: 0,
          max: 10,
        },
      },
    };
  }

  // Fallback for local development with SQLite
  return {
    connection: {
      client: "sqlite",
      connection: {
        filename: path.join(__dirname, "..", ". tmp", "data.db"),
      },
      useNullAsDefault: true,
    },
  };
};
