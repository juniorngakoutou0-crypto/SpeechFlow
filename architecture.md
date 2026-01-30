# SpeechFlow - Technical Architecture (100% Local Deployment)

## Executive Summary

**Deployment Model:** 100% self-hosted on local PC/server
**Cost:** FREE (development) | ~$10-15/month (production electricity)
**Architecture:** Microservices (Node.js + Python hybrid)
**Containerization:** Docker Compose

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         FRONTEND                             │
│              Next.js 15 + TypeScript + Tailwind             │
│                     (Port: 3000)                            │
└──────────────────────┬──────────────────────────────────────┘
                       │ REST/WebSocket
┌──────────────────────▼──────────────────────────────────────┐
│                  API GATEWAY (NestJS)                        │
│         Auth, Upload, Folders, Real-time Status             │
│                     (Port: 4000)                            │
└──┬───────────────────────────────────────────────────────┬──┘
   │                                                        │
   │                                                        │
┌──▼────────────────┐         ┌─────────────────────────┐  │
│  PostgreSQL 16    │         │   MinIO (S3 Storage)    │  │
│  Port: 5432       │         │   Ports: 9000, 9001     │  │
│  - Users          │         │   - Audio/Video Files   │  │
│  - Folders        │         │   - Generated PDFs      │  │
│  - PDF Metadata   │         │                         │  │
└───────────────────┘         └─────────────────────────┘  │
                                                            │
                       ┌────────────────────────────────────▼───┐
                       │      Redis + BullMQ                    │
                       │      (Port: 6379)                      │
                       └────────┬───────────────────────────────┘
                                │
                       ┌────────▼───────────────────────────────┐
                       │    PYTHON WORKER SERVICE               │
                       │    - Faster-Whisper (Transcription)    │
                       │    - OpenRouter (LLM)                  │
                       │    - ReportLab (PDF Gen)               │
                       │    - Email Notifications               │
                       └────────────────────────────────────────┘
```

---

## Technology Stack

### Frontend Layer
| Component | Technology | Purpose |
|-----------|-----------|---------|
| Framework | Next.js 15 (App Router) | SSR, React Server Components, SEO |
| Language | TypeScript 5.0+ | Type safety |
| Styling | Tailwind CSS + shadcn/ui | Utility-first CSS + components |
| State Management | Zustand | Lightweight global state |
| API Client | TanStack Query | Server state, caching |
| File Upload | Uppy | Resumable uploads, progress |
| Real-time | Socket.io Client | WebSocket for job status |
| Forms | React Hook Form + Zod | Validation |

### API Layer (Node.js)
| Component | Technology | Purpose |
|-----------|-----------|---------|
| Framework | NestJS 10+ | Enterprise architecture, DI |
| Language | TypeScript 5.0+ | Type safety |
| Auth | Passport JWT | JWT-based authentication |
| Validation | class-validator | DTO validation |
| ORM | Prisma | Type-safe database client |
| File Handling | Multer + Streams | Multipart uploads |
| Queue | BullMQ | Job queue management |
| WebSocket | Socket.io | Real-time updates |
| API Docs | Swagger/OpenAPI | Auto-generated docs |

### Worker Layer (Python)
| Component | Technology | Purpose |
|-----------|-----------|---------|
| Framework | FastAPI (optional API) | Worker management API |
| Language | Python 3.11+ | AI/ML ecosystem |
| Transcription | Faster-Whisper | Local Whisper inference |
| Fallback Trans | Groq API | Burst capacity (15h/day free) |
| LLM Primary | Gemini 2.0 Flash (OpenRouter) | FREE summarization |
| LLM Fallback | Claude Haiku (OpenRouter) | Paid tier ($0.25/1M tokens) |
| PDF Generation | ReportLab | Professional PDFs |
| Task Queue | Python BullMQ Consumer | Redis job processing |
| HTTP Client | httpx | Async API calls |

### Data Layer
| Component | Technology | Storage |
|-----------|-----------|---------|
| Primary DB | PostgreSQL 16 | Relational data |
| ORM | Prisma | Type-safe queries |
| Object Storage | MinIO | S3-compatible (audio/video/PDFs) |
| Cache | Redis 7 | Session, queue, cache |
| Queue | BullMQ (Redis) | Async job processing |

### Infrastructure (100% Local)
| Component | Technology | Purpose |
|-----------|-----------|---------|
| Containerization | Docker 24+ | Service isolation |
| Orchestration | Docker Compose | Multi-container apps |
| Reverse Proxy | Caddy 2 (optional) | Auto HTTPS, routing |
| Monitoring | Bull Board | Queue monitoring UI |
| Backups | Custom scripts | Automated local backups |

### External Services (Free Tiers)
| Service | Purpose | Free Tier |
|---------|---------|-----------|
| Resend | Email delivery | 100/day, 3,000/month |
| OpenRouter | LLM API | Gemini 2.0 Flash FREE |
| Groq | Whisper API fallback | 15 hours/day |

---

## Database Schema (Prisma)

```prisma
// prisma/schema.prisma

model User {
  id            String    @id @default(uuid())
  email         String    @unique
  passwordHash  String
  name          String?
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt
  folders       Folder[]
  pdfs          PDF[]
}

model Folder {
  id          String   @id @default(uuid())
  name        String
  userId      String
  user        User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  pdfs        PDF[]
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  @@index([userId])
}

model PDF {
  id                String      @id @default(uuid())
  title             String
  originalFileName  String
  fileUrl           String      // MinIO URL
  thumbnailUrl      String?
  status            PDFStatus   @default(PROCESSING)

  // Source files
  audioFileUrl      String?
  videoFileUrl      String?

  // Processing results
  transcriptionText String?     @db.Text
  summaryText       String?     @db.Text

  // Metadata
  duration          Int?        // seconds
  fileSize          BigInt      // bytes

  // Relationships
  userId            String
  user              User        @relation(fields: [userId], references: [id], onDelete: Cascade)
  folderId          String?
  folder            Folder?     @relation(fields: [folderId], references: [id], onDelete: SetNull)

  // Timestamps
  createdAt         DateTime    @default(now())
  updatedAt         DateTime    @updatedAt
  processedAt       DateTime?

  @@index([userId])
  @@index([folderId])
  @@index([status])
}

enum PDFStatus {
  UPLOADING
  PROCESSING
  COMPLETED
  FAILED
}
```

---

## API Endpoints

### Authentication
```
POST   /auth/register        - Register new user
POST   /auth/login           - Login (returns JWT)
POST   /auth/refresh         - Refresh access token
POST   /auth/logout          - Logout
GET    /auth/me              - Get current user
```

### Folders
```
GET    /folders              - List user folders
POST   /folders              - Create folder
GET    /folders/:id          - Get folder details
PATCH  /folders/:id          - Update folder
DELETE /folders/:id          - Delete folder
```

### PDFs
```
GET    /pdfs                 - List user PDFs (with filters)
POST   /pdfs/upload          - Upload audio/video file
GET    /pdfs/:id             - Get PDF details
PATCH  /pdfs/:id             - Update PDF metadata
DELETE /pdfs/:id             - Delete PDF
GET    /pdfs/:id/download    - Download PDF
POST   /pdfs/:id/regenerate  - Regenerate PDF with new settings
```

### Jobs (Admin/Debug)
```
GET    /jobs                 - List jobs (admin)
GET    /jobs/:id             - Get job status
POST   /jobs/:id/retry       - Retry failed job
```

### WebSocket Events
```
client → server:
  - subscribe:pdf:{pdfId}     - Subscribe to PDF updates

server → client:
  - pdf:status:{pdfId}        - Status update
    { status, progress, message }
```

---

## Job Queue Flow

### Queue: `pdf-processing`

**Job Data:**
```typescript
{
  pdfId: string;
  userId: string;
  fileUrl: string;      // MinIO URL
  fileType: 'audio' | 'video';
  settings: {
    language: 'fr' | 'en';
    summaryLength: 'short' | 'medium' | 'long';
  }
}
```

**Worker Steps:**

1. **Download File** (from MinIO)
   - Stream to temp directory
   - Extract audio if video
   - Update status: `PROCESSING` (10%)

2. **Transcription** (Faster-Whisper)
   - Load model (large-v3)
   - Transcribe audio
   - Format with timestamps
   - Update status: (50%)
   - Fallback to Groq if local fails

3. **Summarization** (OpenRouter)
   - Send transcript to Gemini 2.0 Flash
   - Generate structured summary
   - Extract key points
   - Update status: (75%)

4. **PDF Generation** (ReportLab)
   - Create PDF with template
   - Add transcript + summary
   - Table of contents
   - Upload to MinIO
   - Update status: (90%)

5. **Notification** (Resend)
   - Send email to user
   - Update status: `COMPLETED` (100%)

**Error Handling:**
- Retry: 3 attempts with exponential backoff
- On failure: Update status to `FAILED`, send error email

---

## File Storage (MinIO)

### Buckets

**1. `uploads`** (Original files)
```
/audio/{userId}/{pdfId}/original.{ext}
/video/{userId}/{pdfId}/original.{ext}
```

**2. `pdfs`** (Generated PDFs)
```
/{userId}/{pdfId}/document.pdf
/{userId}/{pdfId}/thumbnail.png
```

**3. `temp`** (Processing artifacts, auto-delete after 24h)
```
/{pdfId}/audio-extracted.wav
/{pdfId}/transcript.json
```

### Access Policies
- Private by default
- Pre-signed URLs for downloads (1h expiry)
- User isolation by path prefix

---

## Environment Variables

### Frontend (.env.local)
```bash
NEXT_PUBLIC_API_URL=http://localhost:4000
NEXT_PUBLIC_WS_URL=ws://localhost:4000
```

### Backend (.env)
```bash
# Database
DATABASE_URL=postgresql://speechflow:password@postgres:5432/speechflow

# Redis
REDIS_URL=redis://redis:6379

# MinIO
S3_ENDPOINT=http://minio:9000
S3_ACCESS_KEY=admin
S3_SECRET_KEY=yourpassword
S3_BUCKET_UPLOADS=uploads
S3_BUCKET_PDFS=pdfs

# JWT
JWT_SECRET=your-secret-key-change-in-production
JWT_EXPIRES_IN=7d

# Email
RESEND_API_KEY=re_xxxxxxxxxxxxx
EMAIL_FROM=noreply@yourdomain.com

# OpenRouter
OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxxx

# Worker
WORKER_CONCURRENCY=2
```

### Python Worker (.env)
```bash
REDIS_URL=redis://redis:6379
DATABASE_URL=postgresql://speechflow:password@postgres:5432/speechflow
OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxxx
GROQ_API_KEY=gsk_xxxxxxxxxxxxx
S3_ENDPOINT=http://minio:9000
S3_ACCESS_KEY=admin
S3_SECRET_KEY=yourpassword
```

---

## Docker Compose Services

### Service Map
| Service | Image | Ports | Volumes | Purpose |
|---------|-------|-------|---------|---------|
| frontend | custom | 3000 | - | Next.js app |
| api | custom | 4000 | - | NestJS API |
| worker | custom | - | - | Python processor |
| postgres | postgres:16-alpine | 5432 | postgres_data | Database |
| redis | redis:7-alpine | 6379 | redis_data | Queue/cache |
| minio | minio/minio | 9000, 9001 | minio_data | Object storage |
| caddy | caddy:2-alpine | 80, 443 | caddy_data | Reverse proxy |

### Resource Limits (Production)
```yaml
services:
  api:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
        reservations:
          cpus: '1'
          memory: 1G

  worker:
    deploy:
      resources:
        limits:
          cpus: '4'
          memory: 8G  # For Faster-Whisper
        reservations:
          cpus: '2'
          memory: 4G
```

---

## Performance Benchmarks

### Transcription (Faster-Whisper on CPU)
| File Length | CPU (8-core) | GPU (RTX 3060) |
|-------------|--------------|----------------|
| 10 minutes | ~2 min | ~30 sec |
| 1 hour | ~10 min | ~2 min |
| 2 hours | ~20 min | ~4 min |

### LLM Summarization (Gemini 2.0 Flash)
| Transcript Length | Processing Time | Cost |
|-------------------|-----------------|------|
| 5,000 tokens | ~2-5 sec | FREE |
| 20,000 tokens | ~5-10 sec | FREE |
| 50,000 tokens | ~10-20 sec | FREE |

### PDF Generation (ReportLab)
| Page Count | Processing Time |
|------------|-----------------|
| 10 pages | ~1 sec |
| 50 pages | ~3 sec |
| 100 pages | ~5 sec |

### Concurrent Job Capacity (Single Server)
| Hardware | Concurrent Jobs | Throughput |
|----------|----------------|------------|
| 8-core CPU, 16GB RAM | 2 | ~6 jobs/hour |
| 16-core CPU, 32GB RAM | 4 | ~12 jobs/hour |
| + GPU (RTX 3060) | 4 | ~30 jobs/hour |

---

## Scaling Strategy

### Phase 1: Single Server (0-100 users)
- All services on one machine
- Docker Compose
- 8-core CPU, 16GB RAM, 500GB SSD
- **Cost:** Electricity only (~$10/month)

### Phase 2: Dedicated Worker (100-1,000 users)
- Separate worker instance with GPU
- Load balancer (Nginx)
- Shared PostgreSQL/Redis/MinIO
- **Cost:** +GPU server (~$30/month if Hetzner)

### Phase 3: Kubernetes (1,000-10,000 users)
- k3s cluster (3 nodes)
- Horizontal pod autoscaling
- Managed PostgreSQL
- **Cost:** ~$150-300/month

### Phase 4: Cloud-Native (10,000+ users)
- AWS/GCP with auto-scaling
- Managed services (RDS, ElastiCache, S3)
- CDN (Cloudflare)
- **Cost:** $500-2,000/month

---

## Security Measures

### Application Security
- JWT with short expiry (7 days) + refresh tokens
- Bcrypt password hashing (cost: 10)
- CORS whitelist
- Rate limiting (express-rate-limit)
- File upload validation (type, size)
- SQL injection prevention (Prisma)
- XSS prevention (React escaping)

### Infrastructure Security
- Non-root Docker users
- Secret management (Docker secrets)
- Network isolation (Docker networks)
- MinIO bucket policies (private by default)
- PostgreSQL SSL (production)
- Firewall rules (only expose necessary ports)

### Data Privacy
- User data isolation (RLS if using Supabase)
- Automatic temp file cleanup
- GDPR compliance (data export/delete)
- No data sent to external APIs (except LLM prompts)
- Encrypted backups

---

## Backup Strategy (Local)

### Automated Daily Backups
```bash
# PostgreSQL dump
docker-compose exec -T postgres pg_dump -U speechflow > \
  /backups/postgres/$(date +%Y%m%d).sql

# MinIO sync
mc mirror minio/uploads /backups/minio/uploads
mc mirror minio/pdfs /backups/minio/pdfs

# Compress and encrypt
tar -czf /backups/archive/$(date +%Y%m%d).tar.gz \
  /backups/postgres /backups/minio
```

### Backup Targets
- External HDD/SSD (daily)
- NAS (daily)
- Cloud backup (weekly, encrypted) - optional

### Retention Policy
- Daily backups: 7 days
- Weekly backups: 4 weeks
- Monthly backups: 12 months

---

## Monitoring & Logging

### Application Monitoring
- Bull Board (queue): http://localhost:4000/admin/queues
- MinIO Console: http://localhost:9001
- Prisma Studio (dev): http://localhost:5555

### Optional: Grafana + Prometheus
- CPU/Memory/Disk metrics
- Request rate/latency
- Queue depth/processing time
- Error rates

### Logs
- Docker Compose logs: `docker-compose logs -f`
- Persistent logs: JSON files in `/var/log/speechflow`
- Log rotation: 7 days

---

## Development Workflow

### Initial Setup
```bash
# Clone repository
git clone <repo-url>
cd speechflow

# Copy environment files
cp .env.example .env
cp apps/frontend/.env.example apps/frontend/.env.local

# Start services
docker-compose up -d

# Install dependencies
cd apps/frontend && npm install
cd ../api && npm install
cd ../worker && pip install -r requirements.txt

# Run migrations
cd apps/api && npx prisma migrate dev

# Download Whisper model (once)
cd apps/worker && python -c "from faster_whisper import WhisperModel; WhisperModel('large-v3')"
```

### Daily Development
```bash
# Start all services
docker-compose -f docker-compose.dev.yml up

# Frontend: http://localhost:3000
# API: http://localhost:4000
# MinIO Console: http://localhost:9001
# Bull Board: http://localhost:4000/admin/queues
```

### Testing
```bash
# Frontend
cd apps/frontend && npm test

# API
cd apps/api && npm test

# Worker
cd apps/worker && pytest
```

---

## Deployment (Production)

### Local Server Setup
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Clone repository
git clone <repo-url>
cd speechflow

# Configure environment
cp .env.production .env
# Edit .env with production values

# Build images
docker-compose -f docker-compose.prod.yml build

# Start services
docker-compose -f docker-compose.prod.yml up -d

# Setup backups
chmod +x scripts/backup.sh
crontab -e
# Add: 0 2 * * * /path/to/speechflow/scripts/backup.sh
```

### Health Checks
```bash
# API health
curl http://localhost:4000/health

# Database
docker-compose exec postgres pg_isready

# Redis
docker-compose exec redis redis-cli ping

# MinIO
curl http://localhost:9000/minio/health/live
```

---

## Cost Analysis (Local Deployment)

### Hardware (One-Time)
| Component | Spec | Cost |
|-----------|------|------|
| CPU | 8-core (e.g., Ryzen 7) | $200 |
| RAM | 32GB DDR4 | $100 |
| SSD | 1TB NVMe | $80 |
| GPU (optional) | RTX 3060 (12GB) | $300 |
| Case + PSU | Mid-tower | $100 |
| **Total** | | **$780** (or $480 without GPU) |

### Recurring Costs
| Item | Cost/Month |
|------|-----------|
| Electricity (100W 24/7) | $10-15 |
| Internet (existing) | $0 |
| Domain (optional) | $1 |
| **Total** | **$11-16/month** |

### Usage Costs (API Services)
| Service | Free Tier | Cost After Free |
|---------|-----------|-----------------|
| Resend | 3,000 emails/month | $0.01/email |
| Gemini 2.0 Flash | Generous (10 RPM) | FREE |
| Groq Whisper | 15 hours/day | $0.111/hour |

**Typical Monthly Cost (100 users):**
- Electricity: $12
- LLM: $0 (within free tier)
- Transcription: $0 (local + Groq free tier)
- Email: $0 (within free tier)
- **Total: ~$12/month**

---

## Migration to Cloud (Optional)

### If You Outgrow Local Server

**Recommended Path:**
1. **Database:** Migrate to Neon (generous free tier, then $20/month)
2. **Storage:** Cloudflare R2 ($0.015/GB, no egress fees)
3. **Compute:** Railway or Fly.io ($5-20/month)
4. **Workers:** Keep local initially, then scale horizontally

**Break-Even Analysis:**
- Local: $12/month fixed + hardware amortization (~$20/month over 3 years)
- Cloud: $0/month (free tiers) → $150+/month at scale

**Recommendation:** Start local, migrate specific components to cloud as needed.

---

## Troubleshooting

### Common Issues

**1. Faster-Whisper Out of Memory**
- Reduce model size: `large-v3` → `medium` → `small`
- Reduce batch size in worker config
- Enable GPU inference

**2. MinIO Connection Issues**
- Check Docker network: `docker network inspect speechflow_default`
- Verify S3_ENDPOINT uses service name: `http://minio:9000`

**3. Queue Jobs Stuck**
- Check worker logs: `docker-compose logs -f worker`
- Inspect Redis: `docker-compose exec redis redis-cli KEYS bull:*`
- Restart worker: `docker-compose restart worker`

**4. Database Migration Errors**
- Reset dev DB: `npx prisma migrate reset`
- Production: Create backup first, then `npx prisma migrate deploy`

---

## Next Steps

1. **Setup Project Structure** (Week 1)
   - Create monorepo folders
   - Initialize Next.js, NestJS, Python projects
   - Setup Docker Compose

2. **Implement Core Services** (Week 2-3)
   - Database schema (Prisma)
   - Authentication (JWT)
   - File upload (MinIO)
   - Queue system (BullMQ)

3. **Build Processing Pipeline** (Week 4-5)
   - Faster-Whisper integration
   - OpenRouter LLM
   - PDF generation
   - Email notifications

4. **Frontend Development** (Week 6-7)
   - Dashboard UI
   - Upload interface
   - Real-time progress
   - PDF viewer

5. **Testing & Deployment** (Week 8)
   - Unit tests
   - Integration tests
   - Production build
   - Backup setup

---

## Conclusion

This architecture provides:

✅ **100% Local Control** - All services run on your hardware
✅ **Cost-Effective** - <$15/month recurring costs
✅ **Scalable** - Clear path from local → cloud
✅ **Modern Stack** - TypeScript + Python best practices
✅ **Production-Ready** - Battle-tested technologies
✅ **Flexible** - Swap components as needs evolve

**Total MVP Development Time:** 6-8 weeks (1 developer)
**Total Startup Cost:** ~$500-800 (hardware) + $0 (software)
**Ongoing Cost:** ~$12/month (electricity + internet)

---

**Document Version:** 1.0
**Last Updated:** 2026-01-30
**Author:** Junior
