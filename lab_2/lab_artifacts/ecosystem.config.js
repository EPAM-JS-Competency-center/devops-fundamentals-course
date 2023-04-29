module.exports = {
  apps: [
    {
      name: 'nestjs-api',
      script: 'dist/main.js',
      watch: true,
      env: {
        PORT: 3000,
        NODE_ENV: 'development',
        ENV_CONFIGURATION: 'dev',
      },
      env_production: {
        PORT: 3000,
        NODE_ENV: 'production',
        ENV_CONFIGURATION: 'prod',
      },
    },
  ],
};
