// =============================================================================
// SERVER CONFIGURATION
// =============================================================================
// Railway provides PORT automatically

module.exports = ({ env }) => ({
  host: env("HOST", "0.0.0.0"),
  port: env.int("PORT", 1337),
  url: env("RAILWAY_PUBLIC_DOMAIN")
    ? `https://${env("RAILWAY_PUBLIC_DOMAIN")}`
    : "",
  app: {
    keys: env.array("APP_KEYS", ["defaultKey1", "defaultKey2"]),
  },
  webhooks: {
    populateRelations: env.bool("WEBHOOKS_POPULATE_RELATIONS", false),
  },
});
