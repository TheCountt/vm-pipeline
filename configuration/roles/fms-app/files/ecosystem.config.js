module.exports = {
    apps: [
      {
        name: "frontend",
        script: "node_modules/next/dist/bin/next", // Path to Next.js binary
        args: "start",
        cwd: "/home/ubuntu/fms-frontend", // Replace with your app's path
        interpreter: "none", // This tells PM2 to use "node" as the interpreter
        autorestart: true,
        watch: false,
        max_memory_restart: "1G",
        env: {
          NODE_PORT: "3000",
          NODE_ENV: "production", // Change to "development" if needed
        },
      },
    ],
  };