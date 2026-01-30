#!/usr/bin/env python3
"""
Application Analyzer for Docker Optimizer
Detects technology stack and proposes architecture
"""

import os
import json
from pathlib import Path
from typing import Dict, List, Set

class AppAnalyzer:
    def __init__(self, root_path: str):
        self.root = Path(root_path)
        self.stack = {
            # Detection
            "detected_technologies": [],
            "frameworks": [],
            "build_tools": [],
            "package_manager": None,
            "main_tech": None,

            # Architecture
            "has_frontend": False,
            "has_backend": False,
            "has_database": False,
            "is_monorepo": False,
            "monorepo_tool": None,
            "services": [],

            # Profiling
            "project_size": "unknown",  # small, medium, large
            "complexity": "unknown",    # simple, moderate, complex
            "file_count": 0,
            "total_size_mb": 0,

            # Files
            "files_found": [],
            "dockerfiles_found": [],

            # Recommendations
            "proposed_architecture": None,
            "optimization_tips": [],
            "estimated_final_size": None,
            "estimated_build_time": None,

            # Security
            "security_issues": [],
            "vulnerabilities_found": 0,
        }

    def analyze(self) -> Dict:
        """Run full analysis"""
        print("🔍 Phase 1: Scanning project structure...")
        self._profile_project()

        print("🔍 Phase 2: Detecting technologies...")
        self._detect_technologies()

        print("🔍 Phase 3: Analyzing architecture...")
        self._detect_architecture()

        print("🔍 Phase 4: Checking for monorepo...")
        self._detect_monorepo()

        print("🔍 Phase 5: Analyzing existing Docker config...")
        self._analyze_existing_docker()

        print("🔍 Phase 6: Security analysis...")
        self._security_analysis()

        print("✨ Phase 7: Generating recommendations...")
        self._propose_optimization()

        print("📊 Phase 8: Estimating metrics...")
        self._estimate_metrics()

        return self.stack

    def _profile_project(self):
        """Profile project size and complexity"""
        try:
            # Count files
            file_count = sum(1 for _ in self.root.rglob("*") if _.is_file())
            self.stack["file_count"] = file_count

            # Estimate size
            total_size = sum(f.stat().st_size for f in self.root.rglob("*") if f.is_file())
            size_mb = total_size / (1024 * 1024)
            self.stack["total_size_mb"] = round(size_mb, 2)

            # Classify project size
            if file_count < 100 or size_mb < 10:
                self.stack["project_size"] = "small"
            elif file_count < 1000 or size_mb < 100:
                self.stack["project_size"] = "medium"
            else:
                self.stack["project_size"] = "large"

            # Estimate complexity
            has_multiple_services = len([d for d in self.root.iterdir() if d.is_dir()]) > 5
            has_complex_deps = self._check_complex_dependencies()

            if has_multiple_services or has_complex_deps:
                self.stack["complexity"] = "complex"
            elif file_count > 500:
                self.stack["complexity"] = "moderate"
            else:
                self.stack["complexity"] = "simple"

        except Exception as e:
            print(f"Warning: Could not profile project: {e}")

    def _check_complex_dependencies(self) -> bool:
        """Check if project has complex dependency structure"""
        # Check for monorepo indicators
        if self._has_files(["lerna.json", "nx.json", "turbo.json", "pnpm-workspace.yaml"]):
            return True

        # Check for multiple package.json files
        package_jsons = list(self.root.rglob("package.json"))
        return len(package_jsons) > 3

    def _detect_monorepo(self):
        """Detect monorepo and its tool"""
        monorepo_tools = {
            "turbo.json": "Turborepo",
            "nx.json": "Nx",
            "lerna.json": "Lerna",
            "pnpm-workspace.yaml": "pnpm workspaces",
            "rush.json": "Rush"
        }

        for file, tool in monorepo_tools.items():
            if (self.root / file).exists():
                self.stack["is_monorepo"] = True
                self.stack["monorepo_tool"] = tool
                self.stack["optimization_tips"].append(f"{tool} monorepo detected - use selective builds")
                break

    def _analyze_existing_docker(self):
        """Analyze existing Docker configuration if present"""
        dockerfiles = list(self.root.rglob("Dockerfile*"))
        compose_files = list(self.root.glob("docker-compose*.yml")) + list(self.root.glob("docker-compose*.yaml"))

        if dockerfiles:
            self.stack["dockerfiles_found"] = [str(f.relative_to(self.root)) for f in dockerfiles]
            self.stack["optimization_tips"].append(f"Found {len(dockerfiles)} existing Dockerfile(s) - can analyze for optimization")

        if compose_files:
            self.stack["optimization_tips"].append("Existing docker-compose found - can be optimized")

    def _security_analysis(self):
        """Basic security analysis"""
        # Check for hardcoded secrets
        sensitive_patterns = [".env", "secrets.json", "credentials.json", "config/secrets"]

        for pattern in sensitive_patterns:
            files = list(self.root.rglob(pattern))
            if files and not any("example" in str(f) for f in files):
                self.stack["security_issues"].append(f"Found {pattern} - ensure not committed")

        # Check for .dockerignore
        if not (self.root / ".dockerignore").exists():
            self.stack["security_issues"].append("No .dockerignore found - should be added")

    def _estimate_metrics(self):
        """Estimate final image size and build time"""
        # Rough estimates based on tech stack and project size
        base_sizes = {
            "Node.js": 150,
            "Bun": 80,
            "Deno": 60,
            "Python": 120,
            "Go": 30,
            "Java": 350,
            "Rust": 50
        }

        if self.stack["main_tech"]:
            base_size = base_sizes.get(self.stack["main_tech"], 200)

            # Adjust for project size
            if self.stack["project_size"] == "large":
                multiplier = 1.5
            elif self.stack["project_size"] == "medium":
                multiplier = 1.2
            else:
                multiplier = 1.0

            estimated = int(base_size * multiplier)
            self.stack["estimated_final_size"] = f"{estimated}MB"

        # Estimate build time
        build_times = {
            "small": "30-45s",
            "medium": "1-2min",
            "large": "3-5min"
        }
        self.stack["estimated_build_time"] = build_times.get(self.stack["project_size"], "unknown")

    def _detect_technologies(self):
        """Detect technologies based on key files"""

        # Bun (Runtime JavaScript ultra-rapide)
        if self._has_files(["bun.lockb", "bunfig.toml"]):
            self.stack["detected_technologies"].append("Bun")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Bun"
            self.stack["optimization_tips"].append("Use oven/bun:1-alpine for ultra-fast builds")

        # Deno (Runtime TypeScript sécurisé)
        elif self._has_files(["deno.json", "deno.jsonc", "deno.lock"]):
            self.stack["detected_technologies"].append("Deno")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Deno"
            self.stack["optimization_tips"].append("Use denoland/deno:alpine for secure TypeScript runtime")

        # Node.js / JavaScript
        elif self._has_files(["package.json"]):
            self.stack["detected_technologies"].append("Node.js")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Node.js"

            pkg_json = self._read_json("package.json")
            if pkg_json:
                scripts = pkg_json.get("scripts", {})
                deps = {**pkg_json.get("dependencies", {}), **pkg_json.get("devDependencies", {})}

                # Detect frameworks
                if "next" in deps:
                    self.stack["detected_technologies"].append("Next.js")
                    self.stack["optimization_tips"].append("Next.js detected - use standalone output mode")
                elif "nuxt" in deps:
                    self.stack["detected_technologies"].append("Nuxt")
                    self.stack["optimization_tips"].append("Nuxt detected - optimize with nitro output")
                elif "vite" in deps:
                    self.stack["detected_technologies"].append("Vite")
                    self.stack["optimization_tips"].append("Vite detected - use multi-stage build")

                if "build" in scripts:
                    self.stack["optimization_tips"].append("Node.js app with build script detected")
                if "dev" in scripts:
                    self.stack["optimization_tips"].append("Development scripts present - use multi-stage build")

        # Python
        if self._has_files(["requirements.txt", "setup.py", "pyproject.toml", "Pipfile"]):
            self.stack["detected_technologies"].append("Python")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Python"
            self.stack["optimization_tips"].append("Use slim/alpine Python image")

        # Go
        if self._has_files(["go.mod", "go.sum"]):
            self.stack["detected_technologies"].append("Go")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Go"
            self.stack["optimization_tips"].append("Multi-stage build recommended for Go")

        # Java
        if self._has_files(["pom.xml", "build.gradle", "build.gradle.kts"]):
            self.stack["detected_technologies"].append("Java")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Java"
            self.stack["optimization_tips"].append("Use Alpine JRE for smaller images")

        # Rust
        if self._has_files(["Cargo.toml"]):
            self.stack["detected_technologies"].append("Rust")
            if not self.stack["main_tech"]:
                self.stack["main_tech"] = "Rust"
            self.stack["optimization_tips"].append("Use scratch or alpine for Rust binaries")

        # Frontend frameworks
        if self._check_frontend():
            self.stack["has_frontend"] = True

        # Databases
        if self._has_files(["docker-compose.yml", "docker-compose.yaml"]):
            if self._contains_database_config():
                self.stack["has_database"] = True

        # Check for databases in deps
        if "PostgreSQL" in self._get_dependencies():
            self.stack["has_database"] = True
            self.stack["services"].append("PostgreSQL")
        if "MySQL" in self._get_dependencies():
            self.stack["has_database"] = True
            self.stack["services"].append("MySQL")
        if "MongoDB" in self._get_dependencies():
            self.stack["has_database"] = True
            self.stack["services"].append("MongoDB")
        if "Redis" in self._get_dependencies():
            self.stack["services"].append("Redis")

    def _check_frontend(self) -> bool:
        """Check if there's a frontend"""
        frontend_files = [
            "package.json",
            "src/App.tsx",
            "src/App.jsx",
            "src/index.tsx",
            "public/index.html",
            "src/main.ts",
            "src/main.js"
        ]

        # Check for React/Vue/Angular
        if self._has_files(["package.json"]):
            pkg = self._read_json("package.json")
            if pkg:
                deps = {**pkg.get("dependencies", {}), **pkg.get("devDependencies", {})}
                if any(k in deps for k in ["react", "vue", "angular", "svelte"]):
                    return True

        return self._has_files(frontend_files)

    def _get_dependencies(self) -> Set[str]:
        """Extract main dependencies"""
        deps = set()

        # From package.json
        if Path(self.root / "package.json").exists():
            pkg = self._read_json("package.json")
            if pkg:
                all_deps = {**pkg.get("dependencies", {}), **pkg.get("devDependencies", {})}
                deps.update(all_deps.keys())

        # From requirements.txt
        if Path(self.root / "requirements.txt").exists():
            with open(self.root / "requirements.txt") as f:
                for line in f:
                    line = line.split("==")[0].split(">=")[0].strip()
                    if line:
                        deps.add(line)

        return deps

    def _detect_architecture(self):
        """Propose architecture based on detection"""
        dirs = [d.name for d in self.root.iterdir() if d.is_dir()]

        # Monolithe (simple app)
        if len(dirs) < 5 and not self.stack["has_frontend"]:
            self.stack["proposed_architecture"] = "monolith"
            return

        # Frontend + Backend
        if (self.stack["has_frontend"] and
            any(t in self.stack["detected_technologies"] for t in ["Node.js", "Python", "Go", "Java"])):
            self.stack["proposed_architecture"] = "full-stack"
            return

        # Monorepo / Microservices
        if any(d in dirs for d in ["services", "packages", "apps"]):
            self.stack["proposed_architecture"] = "microservices"
            return

        self.stack["proposed_architecture"] = "monolith"

    def _propose_optimization(self):
        """Add optimization tips"""
        if self.stack["proposed_architecture"] == "monolith":
            self.stack["optimization_tips"].append("Single Dockerfile recommended")
        elif self.stack["proposed_architecture"] == "full-stack":
            self.stack["optimization_tips"].append("Separate Dockerfiles for frontend and backend")
        elif self.stack["proposed_architecture"] == "microservices":
            self.stack["optimization_tips"].append("docker-compose.yml with service discovery")

        # Runtime-specific optimizations
        if self.stack["main_tech"] == "Node.js":
            self.stack["optimization_tips"].append("Use node:22-alpine base image with cache mounts")
        elif self.stack["main_tech"] == "Bun":
            self.stack["optimization_tips"].append("Use oven/bun:1-alpine for 50% faster builds")
        elif self.stack["main_tech"] == "Deno":
            self.stack["optimization_tips"].append("Use denoland/deno:alpine or compile to single binary")
        elif self.stack["main_tech"] == "Python":
            self.stack["optimization_tips"].append("Use python:3.13-slim base image with pip cache mounts")
        elif self.stack["main_tech"] == "Go":
            self.stack["optimization_tips"].append("Use scratch image for minimal size (<50MB)")

        # BuildKit optimization
        self.stack["optimization_tips"].append("Enable BuildKit with # syntax=docker/dockerfile:1.7")

    def _has_files(self, filenames: List[str]) -> bool:
        """Check if any of the files exist"""
        for filename in filenames:
            if (self.root / filename).exists():
                self.stack["files_found"].append(filename)
                return True
        return False

    def _read_json(self, filename: str) -> Dict:
        """Safely read JSON file"""
        try:
            with open(self.root / filename) as f:
                return json.load(f)
        except:
            return None

    def _contains_database_config(self) -> bool:
        """Check if docker-compose contains database config"""
        try:
            compose_file = None
            if (self.root / "docker-compose.yml").exists():
                compose_file = "docker-compose.yml"
            elif (self.root / "docker-compose.yaml").exists():
                compose_file = "docker-compose.yaml"

            if compose_file:
                with open(self.root / compose_file) as f:
                    content = f.read()
                    return any(db in content for db in ["postgres", "mysql", "mongodb", "redis"])
        except:
            pass
        return False

if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python analyze-app.py <app_path>")
        sys.exit(1)

    app_path = sys.argv[1]
    analyzer = AppAnalyzer(app_path)
    result = analyzer.analyze()

    print(json.dumps(result, indent=2))
