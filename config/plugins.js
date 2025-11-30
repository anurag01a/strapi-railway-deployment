// =============================================================================
// PLUGINS CONFIGURATION
// =============================================================================

module.exports = ({ env }) => ({
  "users-permissions": {
    config: {
      jwt: {
        expiresIn: "7d",
      },
    },
  },
  i18n: {
    enabled: true,
    config: {
      defaultLocale: "en",
      locales: ["en"],
    },
  },
});
