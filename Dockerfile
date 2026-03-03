# Imagen base Python
FROM python:3.10-slim

# Directorio de trabajo
WORKDIR /app

# Copiar dependencias
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar la aplicación
COPY app.py .
COPY templates/ templates/
COPY static/ static/

# Cloud Run asigna el puerto vía variable PORT (por defecto 8080)
ENV PORT=8080
EXPOSE 8080

# Gunicorn para producción
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
