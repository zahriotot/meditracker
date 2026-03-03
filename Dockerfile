# Image de base Python
FROM python:3.9-slim

# Métadonnées
LABEL maintainer="DevOps mHealth Project"
LABEL description="MediTracker - Patient Portal mHealth Application"

# Dossier de travail dans le container
WORKDIR /app

# Variables d'environnement par défaut
ENV IP=0.0.0.0
ENV PORT=5000
ENV FLASK_ENV=production

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copier et installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier tout le code source
COPY . .

# Exposer le port Flask
EXPOSE 5000

# Health check pour le monitoring
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:5000/ || exit 1

# Commande de démarrage
CMD ["python", "app.py"]