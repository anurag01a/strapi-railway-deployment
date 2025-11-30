// =============================================================================
// DATABASE CONFIGURATION FOR RAILWAY
// =============================================================================

const path = require("path");

module.exports = ({ env }) => {
  // Get DATABASE_URL from Railway
  const databaseUrl = env("DATABASE_URL");

  // If DATABASE_URL exists, parse it and use PostgreSQL
  if (databaseUrl) {
    // Parse the connection string
    const url = new URL(databaseUrl);

    return {
      connection: {
        client: "postgres",
        connection: {
          host: url.hostname,
          port: parseInt(url.port, 10) || 5432,
          database: url.pathname.substring(1), // Remove leading '/'
          user: url.username,
          password: url.password,
          ssl: {
            rejectUnauthorized: false,
          },
        },
        pool: {
          min: 0,
          max: 10,
        },
        debug: false,
      },
    };
  }

  // Fallback: Use individual environment variables
  const client = env("DATABASE_CLIENT", "postgres");

  if (client === "postgres") {
    return {
      connection: {
        client: "postgres",
        connection: {
          host: env("DATABASE_HOST", "localhost"),
          port: env.int("DATABASE_PORT", 5432),
          database: env("DATABASE_NAME", "strapi"),
          user: env("DATABASE_USERNAME", "strapi"),
          password: env("DATABASE_PASSWORD", ""),
          ssl: env.bool("DATABASE_SSL", false)
            ? { rejectUnauthorized: false }
            : false,
        },
        pool: {
          min: 0,
          max: 10,
        },
        debug: false,
      },
    };
  }

  // SQLite fallback for local development only
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
