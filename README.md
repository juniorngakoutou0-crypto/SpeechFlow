# SpeechFlow

100% Local Audio/Video to PDF Transcription & Summarization System

## Overview

SpeechFlow is a self-hosted application that converts audio and video files into professionally formatted PDFs with transcriptions and AI-generated summaries. Everything runs locally on your hardware with no cloud dependencies.

### Key Features

- **100% Local Processing** - All services run in Docker containers on your machine
- **Cost-Optimized** - FREE transcription (Faster-Whisper) + FREE LLM (Gemini 2.0 Flash)
- **Enterprise Architecture** - Node.js/TypeScript + Python microservices
- **Professional PDFs** - High-quality PDF generation with transcripts and summaries
- **Real-time Updates** - WebSocket-based progress tracking
- **Self-Hosted Storage** - MinIO (S3-compatible) for all files
- **Queue Management** - BullMQ for async processing with retries

### Tech Stack

- **Frontend:** Next.js 15 + TypeScript + Tailwind CSS
- **API:** NestJS + Prisma + PostgreSQL
- **Worker:** Python + Faster-Whisper + OpenRouter + ReportLab
- **Queue:** BullMQ (Redis)
- **Storage:** MinIO (S3-compatible)
- **Deployment:** Docker Compose

### Cost

- **Development:** FREE (runs on your PC)
- **Production:** ~$10-15/month (electricity for local server)
- **No recurring cloud fees**

---

## Quick Start

### Prerequisites

- **Docker Desktop** (Windows/Mac) or **Docker Engine** (Linux)
- **Node.js 20+** (for local development)
- **Python 3.11+** (for local development)
- **8GB+ RAM** (16GB recommended)
- **50GB+ free disk space** (for models and data)

### Installation

1. **Clone the repository**

```bash
git clone <repository-url>
cd speechflow
```

2. **Configure environment variables**

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your settings
# Required: Set strong passwords and API keys
# Optional: Configure Groq and OpenRouter API keys for enhanced features
```

3. **Start all services**

```bash
# Development (with hot reload)
npm run dev

# Or detached mode
npm run dev:detach
```

4. **Access the application**

- **Frontend:** http://localhost:3000
- **API:** http://localhost:4000
- **MinIO Console:** http://localhost:9001
- **Queue Monitor:** http://localhost:4000/admin/queues

5. **Create your first user**

Navigate to http://localhost:3000/register and create an account.

---

## Project Structure

```
speechflow/
├── apps/
│   ├── frontend/          # Next.js application
│   ├── api/              # NestJS backend
│   └── worker/           # Python processing worker
├── packages/
│   ├── types/            # Shared TypeScript types
│   └── config/           # Shared configurations
├── scripts/
│   ├── backup.sh         # Automated backup script
│   └── restore.sh        # Restore from backup
├── docker-compose.yml    # Development environment
├── docker-compose.prod.yml # Production environment
├── .env.example          # Environment variables template
└── architecture.md       # Detailed technical documentation
```

---

## Development

### Running Individual Services

```bash
# Frontend only
cd apps/frontend
npm install
npm run dev

# API only
cd apps/api
npm install
npm run start:dev

# Worker only
cd apps/worker
pip install -r requirements.txt
python -m src.worker
```

### Database Management

```bash
# Run migrations
npm run db:migrate

# Open Prisma Studio (database GUI)
npm run db:studio

# Reset database (development only)
npm run db:reset
```

### Monitoring

```bash
# View logs
npm run dev:logs

# View specific service logs
docker-compose logs -f api
docker-compose logs -f worker
docker-compose logs -f postgres

# Queue monitoring
npm run queue:monitor
```

---

## Production Deployment

### 1. Configure Production Environment

```bash
# Copy production example
cp .env.example .env

# Edit .env with production values:
# - Strong passwords (POSTGRES_PASSWORD, MINIO_ROOT_PASSWORD)
# - Secure JWT_SECRET (min 32 characters)
# - Production API keys (RESEND_API_KEY, OPENROUTER_API_KEY)
# - Production URLs if deploying to a domain
```

### 2. Build and Start

```bash
# Build production images
npm run build

# Start services
npm run start

# View logs
npm run logs
```

### 3. Setup Automated Backups

```bash
# Make backup script executable
chmod +x scripts/backup.sh

# Test backup
./scripts/backup.sh

# Setup cron job for daily backups (2 AM)
crontab -e
# Add: 0 2 * * * /path/to/speechflow/scripts/backup.sh
```

### 4. SSL/HTTPS (Optional)

Edit `Caddyfile` with your domain:

```caddyfile
yourdomain.com {
    reverse_proxy frontend:3000
}

api.yourdomain.com {
    reverse_proxy api:4000
}
```

Then restart:

```bash
docker-compose restart caddy
```

---

## Configuration

### API Keys (Optional but Recommended)

1. **Resend** (Email notifications)
   - Sign up: https://resend.com
   - Get API key: https://resend.com/api-keys
   - Free tier: 3,000 emails/month

2. **OpenRouter** (LLM summarization)
   - Sign up: https://openrouter.ai
   - Get API key: https://openrouter.ai/keys
   - Use Gemini 2.0 Flash (FREE tier)

3. **Groq** (Fallback transcription)
   - Sign up: https://console.groq.com
   - Get API key: https://console.groq.com/keys
   - Free tier: 15 hours/day

### Worker Configuration

Edit `.env`:

```bash
# Concurrent jobs (adjust based on CPU/RAM)
WORKER_CONCURRENCY=2

# Whisper model: tiny, base, small, medium, large-v3
# larger = better quality but slower
WHISPER_MODEL_SIZE=large-v3

# Device: cpu or cuda (requires GPU)
WHISPER_DEVICE=cpu

# Compute type: int8 (CPU), float16 (GPU)
WHISPER_COMPUTE_TYPE=int8
```

### Resource Limits

Edit `docker-compose.prod.yml` to adjust resource limits:

```yaml
services:
  worker:
    deploy:
      resources:
        limits:
          cpus: '4'
          memory: 8G
```

---

## Usage

### Upload and Process

1. **Login** to the application
2. **Create a folder** (optional, for organization)
3. **Upload audio/video file**
   - Supported formats: MP3, WAV, M4A, MP4, MOV, AVI
   - Max size: 2GB (configurable)
4. **Monitor progress** in real-time
5. **Download PDF** when processing completes

### Processing Pipeline

```
Upload → Transcription (Faster-Whisper) →
Summarization (Gemini 2.0 Flash) →
PDF Generation (ReportLab) →
Email Notification (Resend)
```

### Typical Processing Times

| File Length | CPU (8-core) | GPU (RTX 3060) |
|-------------|--------------|----------------|
| 10 minutes  | ~2 min       | ~30 sec        |
| 1 hour      | ~10 min      | ~2 min         |
| 2 hours     | ~20 min      | ~4 min         |

---

## Backup & Restore

### Automated Backups

```bash
# Manual backup
./scripts/backup.sh

# Backups are stored in /backups/
# - PostgreSQL: /backups/postgres/
# - MinIO: /backups/minio/
# - Archive: /backups/archive/
```

### Restore from Backup

```bash
# List available backups
ls -1 /backups/archive/

# Restore specific backup
./scripts/restore.sh 20260130
```

### External Backup

Edit `scripts/backup.sh` to enable automatic upload:

```bash
# Upload to external server (rsync)
rsync -avz /backups/archive/speechflow_backup_${DATE}.tar.gz \
  user@backup-server:/path/to/backups/

# Or upload to cloud (rclone)
rclone copy /backups/archive/speechflow_backup_${DATE}.tar.gz \
  remote:backups/speechflow/
```

---

## Troubleshooting

### Common Issues

**1. Faster-Whisper Out of Memory**

```bash
# Reduce model size
WHISPER_MODEL_SIZE=medium  # or small

# Or reduce worker concurrency
WORKER_CONCURRENCY=1
```

**2. Queue Jobs Stuck**

```bash
# Check worker logs
docker-compose logs -f worker

# Restart worker
docker-compose restart worker
```

**3. Database Connection Issues**

```bash
# Check database status
docker-compose exec postgres pg_isready

# Restart database
docker-compose restart postgres
```

**4. MinIO Connection Issues**

```bash
# Check MinIO logs
docker-compose logs -f minio

# Verify bucket initialization
docker-compose logs minio-init
```

### Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f api
docker-compose logs -f worker
docker-compose logs -f postgres
docker-compose logs -f redis
docker-compose logs -f minio
```

### Health Checks

```bash
# API health
curl http://localhost:4000/health

# Database
docker-compose exec postgres pg_isready -U speechflow

# Redis
docker-compose exec redis redis-cli ping

# MinIO
curl http://localhost:9000/minio/health/live
```

---

## Performance Optimization

### GPU Acceleration (Optional)

Install NVIDIA drivers and configure:

```yaml
# docker-compose.prod.yml
services:
  worker:
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

Update `.env`:

```bash
WHISPER_DEVICE=cuda
WHISPER_COMPUTE_TYPE=float16
```

### Scaling Workers

```bash
# Increase worker instances
docker-compose up -d --scale worker=3
```

### Database Optimization

```sql
-- Add indexes for common queries
CREATE INDEX CONCURRENTLY idx_pdfs_user_status ON pdfs(user_id, status);
CREATE INDEX CONCURRENTLY idx_pdfs_folder_created ON pdfs(folder_id, created_at DESC);
```

---

## Security

### Production Checklist

- [ ] Change all default passwords
- [ ] Use strong JWT_SECRET (32+ characters)
- [ ] Enable HTTPS (via Caddy)
- [ ] Configure firewall (only expose 80, 443)
- [ ] Setup automated backups
- [ ] Enable rate limiting
- [ ] Review MinIO bucket policies
- [ ] Setup monitoring/alerts

### Environment Variables

Never commit `.env` to version control. Use `.env.example` as template.

### Docker Security

- All services run as non-root users (production)
- Network isolation between services
- Secret management via Docker secrets (optional)

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

---

## License

MIT License - See LICENSE file for details

---

## Support

- **Documentation:** See `architecture.md` for detailed technical docs
- **Issues:** GitHub Issues
- **Discussions:** GitHub Discussions

---

## Roadmap

### V1.0 (Current)
- [x] Audio/video upload
- [x] Transcription (Faster-Whisper)
- [x] LLM summarization
- [x] PDF generation
- [x] Email notifications
- [x] Docker deployment

### V2.0 (Planned)
- [ ] Multi-user support
- [ ] Full-text search
- [ ] Advanced PDF templates
- [ ] Batch processing
- [ ] API for integrations
- [ ] Mobile app (React Native)

---

## Acknowledgments

- **OpenAI Whisper** - Speech recognition model
- **Faster-Whisper** - Optimized Whisper implementation
- **OpenRouter** - Multi-LLM API gateway
- **NestJS** - Progressive Node.js framework
- **Next.js** - React framework
- **MinIO** - S3-compatible object storage
- **BullMQ** - Job queue system

---

**Built with care for privacy-conscious users who value local control.**
