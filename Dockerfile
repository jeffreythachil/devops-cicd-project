# ---------- Stage 1: Builder ----------
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---------- Stage 2: Runtime ----------
FROM python:3.12-slim

WORKDIR /app

# Copy only the installed packages from the builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]