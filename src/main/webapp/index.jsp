<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveEase — Learn to Drive with Confidence</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500;600&display=swap"
        rel="stylesheet">
    <style>
        :root {
            --bg: #0a0a0f;
            --surface: #13131a;
            --card: #1a1a24;
            --accent: #e8c547;
            --accent2: #4f8ef7;
            --text: #f0ede8;
            --muted: #8a8799;
            --border: rgba(255, 255, 255, 0.07);
        }

        *,
        *::before,
        *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            overflow-x: hidden;
        }

        /* Custom cursor */
        .cursor {
            width: 12px;
            height: 12px;
            background: var(--accent);
            border-radius: 50%;
            position: fixed;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 2147483647;
            transition: transform 0.15s ease;
            mix-blend-mode: normal;
            opacity: 0.8;
        }

        .cursor-ring {
            width: 36px;
            height: 36px;
            border: 1.5px solid var(--accent);
            border-radius: 50%;
            position: fixed;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 2147483647;
            transition: transform 0.35s ease, opacity 0.3s;
            opacity: 0.4;
        }

        /* ── NAV ── */
        nav {
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 60px;
            z-index: 100;
            background: linear-gradient(180deg, rgba(10, 10, 15, 0.95) 0%, transparent 100%);
            backdrop-filter: blur(6px);
        }

        .nav-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: var(--text);
        }

        .nav-logo span {
            color: var(--accent);
        }

        .nav-links {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .nav-links a {
            font-size: 0.85rem;
            font-weight: 500;
            color: var(--muted);
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 40px;
            transition: all 0.25s;
            letter-spacing: 0.02em;
        }

        .nav-links a:hover {
            color: var(--text);
            background: var(--border);
        }

        .nav-cta {
            background: var(--accent) !important;
            color: #0a0a0f !important;
            font-weight: 600 !important;
        }

        .nav-cta:hover {
            background: #f5d460 !important;
            transform: translateY(-1px);
        }

        /* ── HERO ── */
        .hero {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            padding: 0 60px;
            gap: 60px;
            position: relative;
            overflow: hidden;
        }

        /* Animated grid background */
        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background-image:
                linear-gradient(rgba(78, 142, 247, 0.04) 1px, transparent 1px),
                linear-gradient(90deg, rgba(78, 142, 247, 0.04) 1px, transparent 1px);
            background-size: 60px 60px;
            animation: gridDrift 20s linear infinite;
        }

        @keyframes gridDrift {
            0% {
                transform: translateY(0);
            }

            100% {
                transform: translateY(60px);
            }
        }

        /* Glow blobs */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            pointer-events: none;
        }

        .blob-1 {
            width: 500px;
            height: 500px;
            background: rgba(78, 142, 247, 0.12);
            top: -100px;
            right: -100px;
            animation: float1 8s ease-in-out infinite;
        }

        .blob-2 {
            width: 300px;
            height: 300px;
            background: rgba(232, 197, 71, 0.08);
            bottom: 100px;
            left: 50px;
            animation: float2 10s ease-in-out infinite;
        }

        @keyframes float1 {

            0%,
            100% {
                transform: translate(0, 0)
            }

            50% {
                transform: translate(-30px, 20px)
            }
        }

        @keyframes float2 {

            0%,
            100% {
                transform: translate(0, 0)
            }

            50% {
                transform: translate(20px, -30px)
            }
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(232, 197, 71, 0.1);
            border: 1px solid rgba(232, 197, 71, 0.3);
            padding: 6px 16px;
            border-radius: 40px;
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--accent);
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 28px;
            animation: fadeUp 0.8s ease both;
        }

        .hero-badge::before {
            content: '';
            width: 6px;
            height: 6px;
            background: var(--accent);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {

            0%,
            100% {
                opacity: 1
            }

            50% {
                opacity: 0.3
            }
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(3rem, 5vw, 5.5rem);
            font-weight: 900;
            line-height: 1.02;
            letter-spacing: -0.03em;
            margin-bottom: 24px;
            animation: fadeUp 0.8s 0.1s ease both;
        }

        .hero-title em {
            font-style: italic;
            color: var(--accent);
        }

        .hero-sub {
            font-size: 1.05rem;
            line-height: 1.7;
            color: var(--muted);
            max-width: 460px;
            margin-bottom: 40px;
            animation: fadeUp 0.8s 0.2s ease both;
            font-weight: 300;
        }

        .hero-actions {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
            animation: fadeUp 0.8s 0.3s ease both;
        }

        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--accent);
            color: #0a0a0f;
            padding: 14px 30px;
            border-radius: 50px;
            font-size: 0.95rem;
            font-weight: 700;
            text-decoration: none;
            letter-spacing: 0.01em;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            border: none;
            cursor: default;
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.03);
            box-shadow: 0 16px 40px rgba(232, 197, 71, 0.3);
        }

        .btn-primary svg {
            transition: transform 0.3s;
        }

        .btn-primary:hover svg {
            transform: translateX(4px);
        }

        .btn-ghost {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: transparent;
            color: var(--text);
            padding: 14px 30px;
            border-radius: 50px;
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            border: 1.5px solid var(--border);
            transition: all 0.3s;
            cursor: default;
        }

        .btn-ghost:hover {
            border-color: rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.05);
        }

        .hero-stats {
            display: flex;
            gap: 40px;
            margin-top: 56px;
            animation: fadeUp 0.8s 0.4s ease both;
        }

        .stat-num {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--text);
            line-height: 1;
        }

        .stat-label {
            font-size: 0.78rem;
            color: var(--muted);
            margin-top: 4px;
            font-weight: 400;
            letter-spacing: 0.04em;
        }

        .stat-divider {
            width: 1px;
            background: var(--border);
            align-self: stretch;
        }

        /* Hero visual */
        .hero-visual {
            position: relative;
            z-index: 2;
            animation: fadeUp 0.8s 0.2s ease both;
        }

        .car-card {
            background: var(--card);
            border-radius: 28px;
            overflow: hidden;
            border: 1px solid var(--border);
            position: relative;
        }

        .car-card::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, transparent 50%, rgba(10, 10, 15, 0.6) 100%);
        }

        .car-img {
            width: 100%;
            aspect-ratio: 4/3;
            object-fit: cover;
            display: block;
            filter: saturate(0.8) brightness(0.9);
            transition: transform 0.8s ease, filter 0.4s;
        }

        .car-card:hover .car-img {
            transform: scale(1.04);
            filter: saturate(1) brightness(1);
        }

        .car-pill {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background: rgba(10, 10, 15, 0.85);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 12px 18px;
            z-index: 3;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .pill-dot {
            width: 8px;
            height: 8px;
            background: #4ade80;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        .pill-text {
            font-size: 0.82rem;
            font-weight: 600;
        }

        .pill-sub {
            font-size: 0.72rem;
            color: var(--muted);
            margin-top: 2px;
        }

        .floating-card {
            position: absolute;
            top: -20px;
            right: -20px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 16px 20px;
            backdrop-filter: blur(20px);
            animation: floatCard 4s ease-in-out infinite;
        }

        @keyframes floatCard {

            0%,
            100% {
                transform: translateY(0)
            }

            50% {
                transform: translateY(-10px)
            }
        }

        .fc-label {
            font-size: 0.72rem;
            color: var(--muted);
            margin-bottom: 6px;
            letter-spacing: 0.04em;
        }

        .fc-rating {
            display: flex;
            align-items: center;
            gap: 6px;
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .stars {
            color: var(--accent);
            font-size: 0.8rem;
            letter-spacing: 2px;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ── FEATURES ── */
        .features {
            padding: 100px 60px;
            position: relative;
        }

        .section-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--accent);
            letter-spacing: 0.12em;
            text-transform: uppercase;
            margin-bottom: 16px;
            display: block;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2rem, 3vw, 3rem);
            font-weight: 700;
            line-height: 1.15;
            letter-spacing: -0.02em;
            margin-bottom: 60px;
            max-width: 500px;
        }

        .section-title em {
            color: var(--accent);
            font-style: italic;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .feat-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 36px 32px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            cursor: default;
        }

        .feat-card::before {
            content: '';
            position: absolute;
            inset: 0;
            opacity: 0;
            transition: opacity 0.4s;
            border-radius: 24px;
        }

        .feat-card:nth-child(1)::before {
            background: radial-gradient(circle at 30% 50%, rgba(78, 142, 247, 0.08) 0%, transparent 70%);
        }

        .feat-card:nth-child(2)::before {
            background: radial-gradient(circle at 30% 50%, rgba(232, 197, 71, 0.08) 0%, transparent 70%);
        }

        .feat-card:nth-child(3)::before {
            background: radial-gradient(circle at 30% 50%, rgba(74, 222, 128, 0.08) 0%, transparent 70%);
        }

        .feat-card:hover::before {
            opacity: 1;
        }

        .feat-card:hover {
            transform: translateY(-6px);
            border-color: rgba(255, 255, 255, 0.14);
        }

        .feat-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 24px;
        }

        .feat-card:nth-child(1) .feat-icon {
            background: rgba(78, 142, 247, 0.15);
        }

        .feat-card:nth-child(2) .feat-icon {
            background: rgba(232, 197, 71, 0.15);
        }

        .feat-card:nth-child(3) .feat-icon {
            background: rgba(74, 222, 128, 0.15);
        }

        .feat-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 12px;
            letter-spacing: -0.01em;
        }

        .feat-text {
            font-size: 0.9rem;
            line-height: 1.7;
            color: var(--muted);
            font-weight: 300;
        }

        /* ── HOW IT WORKS ── */
        .how {
            padding: 100px 60px;
            background: var(--surface);
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 32px;
            margin-top: 60px;
        }

        .step {
            position: relative;
        }

        .step-num {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 900;
            color: rgba(255, 255, 255, 0.04);
            line-height: 1;
            margin-bottom: 16px;
        }

        .step-title {
            font-weight: 700;
            font-size: 1.05rem;
            margin-bottom: 10px;
        }

        .step-text {
            font-size: 0.88rem;
            color: var(--muted);
            line-height: 1.7;
            font-weight: 300;
        }

        .step-connector {
            position: absolute;
            top: 24px;
            left: 100%;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, var(--accent2), transparent);
            opacity: 0.3;
            pointer-events: none;
        }

        .step:last-child .step-connector {
            display: none;
        }

        /* ── COURSES ── */
        .courses {
            padding: 100px 60px;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 60px;
        }

        .course-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            cursor: default;
        }

        .course-card:hover {
            transform: translateY(-8px);
            border-color: rgba(255, 255, 255, 0.14);
        }

        .course-header {
            padding: 32px 28px 24px;
            border-bottom: 1px solid var(--border);
            position: relative;
        }

        .course-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 40px;
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            margin-bottom: 18px;
        }

        .badge-basic {
            background: rgba(78, 142, 247, 0.15);
            color: #4f8ef7;
        }

        .badge-popular {
            background: rgba(232, 197, 71, 0.15);
            color: var(--accent);
        }

        .badge-pro {
            background: rgba(74, 222, 128, 0.15);
            color: #4ade80;
        }

        .course-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: -0.01em;
        }

        .course-price {
            font-family: 'Playfair Display', serif;
            font-size: 2.4rem;
            font-weight: 900;
            color: var(--text);
            margin-bottom: 4px;
        }

        .course-price span {
            font-size: 1rem;
            font-weight: 400;
            color: var(--muted);
        }

        .course-body {
            padding: 24px 28px;
        }

        .course-feature {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.88rem;
            color: var(--muted);
            margin-bottom: 12px;
            font-weight: 400;
        }

        .course-feature::before {
            content: '';
            width: 5px;
            height: 5px;
            border-radius: 50%;
            background: var(--accent);
            flex-shrink: 0;
        }

        .course-btn {
            display: block;
            width: 100%;
            text-align: center;
            padding: 13px;
            border-radius: 14px;
            font-size: 0.9rem;
            font-weight: 700;
            text-decoration: none;
            margin-top: 20px;
            transition: all 0.3s;
            cursor: default;
            border: none;
        }

        .course-btn-primary {
            background: var(--accent);
            color: #0a0a0f;
        }

        .course-btn-primary:hover {
            background: #f5d460;
            transform: translateY(-2px);
        }

        .course-btn-ghost {
            background: transparent;
            color: var(--text);
            border: 1.5px solid var(--border);
        }

        .course-btn-ghost:hover {
            background: rgba(255, 255, 255, 0.06);
        }

        /* ── TESTIMONIALS ── */
        .testimonials {
            padding: 100px 60px;
            background: var(--surface);
            border-top: 1px solid var(--border);
        }

        .testi-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 60px;
        }

        .testi-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 32px;
            transition: all 0.3s;
        }

        .testi-card:hover {
            border-color: rgba(255, 255, 255, 0.14);
            transform: translateY(-4px);
        }

        .testi-stars {
            color: var(--accent);
            font-size: 0.9rem;
            letter-spacing: 3px;
            margin-bottom: 16px;
        }

        .testi-text {
            font-size: 0.95rem;
            line-height: 1.75;
            color: #ccc;
            font-weight: 300;
            margin-bottom: 24px;
            font-style: italic;
        }

        .testi-author {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .testi-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
            color: #0a0a0f;
        }

        .testi-name {
            font-weight: 700;
            font-size: 0.9rem;
        }

        .testi-role {
            font-size: 0.78rem;
            color: var(--muted);
            margin-top: 2px;
        }

        /* ── CTA ── */
        .cta-section {
            padding: 100px 60px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at 50% 50%, rgba(78, 142, 247, 0.08) 0%, transparent 70%);
        }

        .cta-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.5rem, 4vw, 4rem);
            font-weight: 900;
            line-height: 1.1;
            letter-spacing: -0.03em;
            margin-bottom: 20px;
            position: relative;
        }

        .cta-section p {
            font-size: 1.05rem;
            color: var(--muted);
            margin-bottom: 40px;
            font-weight: 300;
            position: relative;
        }

        .cta-btns {
            display: flex;
            gap: 14px;
            justify-content: center;
            position: relative;
        }

        /* ── FOOTER ── */
        footer {
            padding: 48px 60px;
            border-top: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .footer-logo span {
            color: var(--accent);
        }

        .footer-links {
            display: flex;
            gap: 28px;
        }

        .footer-links a {
            font-size: 0.85rem;
            color: var(--muted);
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: var(--text);
        }

        .footer-copy {
            font-size: 0.78rem;
            color: var(--muted);
        }

        /* Scroll reveal */
        .reveal {
            opacity: 0;
            transform: translateY(40px);
            transition: opacity 0.7s ease, transform 0.7s ease;
        }

        .reveal.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>

<body>

    <div class="cursor" id="cursor"></div>
    <div class="cursor-ring" id="cursorRing"></div>

    <!-- NAV -->
    <nav>
        <div class="nav-logo">Drive<span>Ease</span></div>
        <div class="nav-links">
            <a href="#features">Features</a>
            <a href="#courses">Courses</a>
            <a href="admin_login.jsp">Admin Login</a>
            <a href="student_login.jsp">Student Login</a>
            <a href="StudentServlet?action=new" class="nav-cta">Register Now</a>
        </div>
    </nav>

    <!-- HERO -->
    <section class="hero">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>

        <div class="hero-content">
            <div class="hero-badge">Now enrolling — 2026</div>
            <h1 class="hero-title">
                Learn to Drive<br>with <em>Confidence</em>
            </h1>
            <p class="hero-sub">
                Join our driving school and master the road with expert instructors. Book lessons, track your progress,
                and earn your license — all in one place.
            </p>
            <div class="hero-actions">
                <a href="StudentServlet?action=new" class="btn-primary">
                    Become a Student
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
                            stroke-linejoin="round" />
                    </svg>
                </a>
                <a href="student_login.jsp" class="btn-ghost">Student Portal</a>
            </div>
            <div class="hero-stats">
                <div class="stat-item">
                    <div class="stat-num">2,400+</div>
                    <div class="stat-label">Students Trained</div>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <div class="stat-num">94%</div>
                    <div class="stat-label">First-Pass Rate</div>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <div class="stat-num">48</div>
                    <div class="stat-label">Expert Instructors</div>
                </div>
            </div>
        </div>

        <div class="hero-visual">
            <div class="floating-card">
                <div class="fc-label">Student Rating</div>
                <div class="fc-rating">
                    4.9
                    <div>
                        <div class="stars">★★★★★</div>
                    </div>
                </div>
            </div>
            <div class="car-card">
                <img src="images/hero-lesson.jpg" alt="Driving Lesson"
                    class="car-img">
                <div class="car-pill">
                    <div class="pill-dot"></div>
                    <div>
                        <div class="pill-text">Live Lesson in Progress</div>
                        <div class="pill-sub">James T. — Route 12B</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="features" id="features">
        <span class="section-label reveal">Why DriveEase</span>
        <h2 class="section-title reveal">Everything you need to <em>get licensed</em></h2>
        <div class="features-grid">
            <div class="feat-card reveal">
                <div class="feat-icon">📅</div>
                <h3 class="feat-title">Easy Scheduling</h3>
                <p class="feat-text">Book your driving lessons at times that suit your lifestyle. Choose your preferred
                    instructor and vehicle type effortlessly online with our smart calendar system.</p>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon">🎓</div>
                <h3 class="feat-title">Expert Instructors</h3>
                <p class="feat-text">Learn from fully qualified, government-certified instructors who are dedicated to
                    your success. Personalized feedback after every lesson to accelerate your progress.</p>
            </div>
            <div class="feat-card reveal">
                <div class="feat-icon">💳</div>
                <h3 class="feat-title">Transparent Payments</h3>
                <p class="feat-text">View your full payment history securely online. Receive smart notifications for
                    upcoming dues and manage your course fees with complete transparency.</p>
            </div>
        </div>
    </section>

    <!-- HOW IT WORKS -->
    <section class="how">
        <span class="section-label reveal">Simple Process</span>
        <h2 class="section-title reveal">From sign-up to <em>license</em> in four steps</h2>
        <div class="steps">
            <div class="step reveal">
                <div class="step-num">01</div>
                <h3 class="step-title">Register Online</h3>
                <p class="step-text">Create your account in under two minutes and choose your preferred course package.
                </p>
                <div class="step-connector"></div>
            </div>
            <div class="step reveal">
                <div class="step-num">02</div>
                <h3 class="step-title">Pick an Instructor</h3>
                <p class="step-text">Browse instructor profiles, ratings, and availability to find your perfect match.
                </p>
                <div class="step-connector"></div>
            </div>
            <div class="step reveal">
                <div class="step-num">03</div>
                <h3 class="step-title">Book & Learn</h3>
                <p class="step-text">Schedule lessons at your convenience and track every session in your dashboard.</p>
                <div class="step-connector"></div>
            </div>
            <div class="step reveal">
                <div class="step-num">04</div>
                <h3 class="step-title">Get Licensed</h3>
                <p class="step-text">Pass your driving test with confidence and receive your license — we celebrate with
                    you!</p>
            </div>
        </div>
    </section>

    <!-- COURSES -->
    <section class="courses" id="courses">
        <span class="section-label reveal">Pricing</span>
        <h2 class="section-title reveal">Courses built for <em>every learner</em></h2>
        <div class="courses-grid">
            <div class="course-card reveal">
                <div class="course-header">
                    <span class="course-badge badge-basic">Starter</span>
                    <div class="course-name">Basic Course</div>
                    <div class="course-price">LKR 15,000<span>/package</span></div>
                </div>
                <div class="course-body">
                    <div class="course-feature">10 driving lessons (1hr each)</div>
                    <div class="course-feature">1 assigned instructor</div>
                    <div class="course-feature">Progress tracking dashboard</div>
                    <div class="course-feature">Theory test prep materials</div>
                    <a href="StudentServlet?action=new" class="course-btn course-btn-ghost">Get Started</a>
                </div>
            </div>
            <div class="course-card reveal">
                <div class="course-header">
                    <span class="course-badge badge-popular">Most Popular</span>
                    <div class="course-name">Standard Course</div>
                    <div class="course-price">LKR 35,000<span>/package</span></div>
                </div>
                <div class="course-body">
                    <div class="course-feature">20 driving lessons (1hr each)</div>
                    <div class="course-feature">Choose your instructor</div>
                    <div class="course-feature">Mock test sessions included</div>
                    <div class="course-feature">Priority booking access</div>
                    <div class="course-feature">Post-lesson video feedback</div>
                    <a href="StudentServlet?action=new" class="course-btn course-btn-primary">Get Started</a>
                </div>
            </div>
            <div class="course-card reveal">
                <div class="course-header">
                    <span class="course-badge badge-pro">Pro</span>
                    <div class="course-name">Intensive Course</div>
                    <div class="course-price">LKR 55,000<span>/package</span></div>
                </div>
                <div class="course-body">
                    <div class="course-feature">Unlimited lessons for 6 weeks</div>
                    <div class="course-feature">Dedicated senior instructor</div>
                    <div class="course-feature">Full test preparation program</div>
                    <div class="course-feature">Highway & night driving</div>
                    <div class="course-feature">Pass guarantee or refund</div>
                    <a href="StudentServlet?action=new" class="course-btn course-btn-ghost">Get Started</a>
                </div>
            </div>
        </div>
    </section>

    <!-- TESTIMONIALS -->
    <section class="testimonials">
        <span class="section-label reveal">Student Stories</span>
        <h2 class="section-title reveal">Trusted by thousands of <em>happy drivers</em></h2>
        <div class="testi-grid">
            <div class="testi-card reveal">
                <div class="testi-stars">★★★★★</div>
                <p class="testi-text">"I passed my test on the first try after only 3 weeks with DriveEase. My
                    instructor was incredibly patient and the booking system made everything so easy."</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:#e8c547">S</div>
                    <div>
                        <div class="testi-name">Sarah M.</div>
                        <div class="testi-role">Passed — October 2025</div>
                    </div>
                </div>
            </div>
            <div class="testi-card reveal">
                <div class="testi-stars">★★★★★</div>
                <p class="testi-text">"The dashboard and progress tracking is amazing. I could see exactly where I
                    needed to improve, and my instructor used that data to personalise every lesson."</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:#4f8ef7">D</div>
                    <div>
                        <div class="testi-name">Daniel K.</div>
                        <div class="testi-role">Passed — January 2026</div>
                    </div>
                </div>
            </div>
            <div class="testi-card reveal">
                <div class="testi-stars">★★★★★</div>
                <p class="testi-text">"Booking was a breeze and the payment system is crystal-clear. No hidden fees, no
                    surprises. Loved the experience from sign-up to getting my license!"</p>
                <div class="testi-author">
                    <div class="testi-avatar" style="background:#4ade80">P</div>
                    <div>
                        <div class="testi-name">Priya L.</div>
                        <div class="testi-role">Passed — February 2026</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="cta-section">
        <h2 class="reveal">Ready to hit<br>the road?</h2>
        <p class="reveal">Join over 2,400 students who've earned their license with DriveEase.</p>
        <div class="cta-btns reveal">
            <a href="StudentServlet?action=new" class="btn-primary">
                Register Today
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                    <path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
                        stroke-linejoin="round" />
                </svg>
            </a>
            <a href="admin_login.jsp" class="btn-ghost">Admin Portal</a>
        </div>
    </section>

    <!-- FOOTER -->
    <footer>
        <div class="footer-logo">Drive<span>Ease</span></div>
        <div class="footer-links">
            <a href="#">About</a>
            <a href="#">Privacy</a>
            <a href="#">Terms</a>
            <a href="#">Contact</a>
        </div>
        <div class="footer-copy">© 2026 DriveEase. All rights reserved.</div>
    </footer>

    <script>
        // Custom cursor
        const cursor = document.getElementById('cursor');
        const ring = document.getElementById('cursorRing');
        let mx = window.innerWidth / 2, my = window.innerHeight / 2;
        let rx = mx, ry = my;
        let initialized = false;

        document.addEventListener('mousemove', e => {
            mx = e.clientX; my = e.clientY;
            if(!initialized) {
                cursor.style.opacity = "1";
                ring.style.opacity = "0.5";
                initialized = true;
            }
            cursor.style.transform = `translate(${mx - 6}px, ${my - 6}px)`;
        });

        // Add hover effects for buttons and links
        let currentScale = 1;
        let targetScale = 1;

        document.querySelectorAll('a, button, .feat-card, .course-card, input, select, textarea').forEach(el => {
            el.addEventListener('mouseenter', () => {
                targetScale = 1.5;
                ring.style.background = "rgba(232, 197, 71, 0.1)";
            });
            el.addEventListener('mouseleave', () => {
                targetScale = 1;
                ring.style.background = "transparent";
            });
        });

        function animRing() {
            rx += (mx - rx) * 0.12;
            ry += (my - ry) * 0.12;
            currentScale += (targetScale - currentScale) * 0.15;
            
            ring.style.transform = `translate(${rx - 18}px, ${ry - 18}px) scale(${currentScale})`;
            requestAnimationFrame(animRing);
        }
        animRing();

        // Scroll reveal
        const obs = new IntersectionObserver((entries) => {
            entries.forEach((e, i) => {
                if (e.isIntersecting) {
                    setTimeout(() => e.target.classList.add('visible'), i * 80);
                }
            });
        }, { threshold: 0.1 });
        document.querySelectorAll('.reveal').forEach(el => obs.observe(el));
    </script>
</body>

</html>
