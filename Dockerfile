# Imagen oficial de Node.js 22 slim
FROM node:22-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos solo archivos de dependencias primero para usar cache de Docker
COPY package*.json ./

# Instalamos dependencias de Node
RUN npm ci

# Copiamos el resto del código
COPY . .

# Ajustamos permisos para ejecutar como usuario no-root
RUN chown -R node:node /app

# Ejecutar la app como usuario seguro
USER node

# Comando principal al iniciar el contenedor
CMD ["npm", "start"]
