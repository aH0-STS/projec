                                                      
# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy files
COPY package.json .
COPY app.js .

# Expose port
EXPOSE 80

# Command to run the app
CMD ["node", "app.js"]













