<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal Login - DriveEase</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500;600&display=swap"
        rel="stylesheet">
    <style>
        :root {
            --bg: #0a0a0f;
            --surface: #13131a;
            --card: #1a1a24;
            --accent: #e8c547;
            --text: #f0ede8;
            --muted: #8a8799;
            --border: rgba(255, 255, 255, 0.07);
            --success: #4ade80;
            --error: #f87171;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Custom cursor */
        .cursor {
            width: 12px; height: 12px; background: var(--accent); border-radius: 50%;
            position: fixed; top: 0; left: 0; pointer-events: none; z-index: 10001;
            transition: transform 0.15s ease; mix-blend-mode: normal; opacity: 0.8;
        }
        .cursor-ring {
            width: 36px; height: 36px; border: 1.5px solid var(--accent); border-radius: 50%;
            position: fixed; top: 0; left: 0; pointer-events: none; z-index: 10000;
            transition: transform 0.35s ease, opacity 0.3s; opacity: 0.4;
        }

        /* Background grid */
        .grid-bg {
            position: absolute; inset: 0;
            background-image: linear-gradient(rgba(78, 142, 247, 0.04) 1px, transparent 1px),
                              linear-gradient(90deg, rgba(78, 142, 247, 0.04) 1px, transparent 1px);
            background-size: 60px 60px;
            z-index: -1;
        }

        .login-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 28px;
            width: 100%;
            max-width: 440px;
            padding: 48px;
            position: relative;
            z-index: 2;
            box-shadow: 0 40px 100px rgba(0,0,0,0.5);
            animation: fadeUp 0.8s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 32px;
        }
        .logo span { color: var(--accent); }

        .title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 8px;
            text-align: center;
        }
        .subtitle {
            color: var(--muted);
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 32px;
            font-weight: 300;
        }

        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            font-size: 0.8rem;
            color: var(--muted);
            margin-bottom: 8px;
            font-weight: 500;
            letter-spacing: 0.02em;
        }
        .form-input {
            width: 100%;
            background: rgba(255,255,255,0.03);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 14px 18px;
            color: var(--text);
            font-family: inherit;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        .form-input:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255,255,255,0.05);
        }

        .btn-submit {
            width: 100%;
            background: var(--accent);
            color: #0a0a0f;
            border: none;
            border-radius: 12px;
            padding: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: default;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-top: 12px;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(232, 197, 71, 0.2);
        }

        .alert {
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 0.85rem;
            margin-bottom: 24px;
        }
        .alert-error { background: rgba(248, 113, 113, 0.1); border: 1px solid rgba(248, 113, 113, 0.2); color: var(--error); }
        .alert-success { background: rgba(74, 222, 128, 0.1); border: 1px solid rgba(74, 222, 128, 0.2); color: var(--success); }

        .footer-links {
            margin-top: 32px;
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
        }
        .footer-links a {
            color: var(--muted);
            text-decoration: none;
            transition: color 0.2s;
        }
        .footer-links a:hover { color: var(--text); }

    </style>
</head>
<body>

    <div class="cursor" id="cursor"></div>
    <div class="cursor-ring" id="cursorRing"></div>
    <div class="grid-bg"></div>

    <div class="login-card">
        <div class="logo">Drive<span>Ease</span></div>
        <h2 class="title">Student Portal</h2>
        <p class="subtitle">Enter your credentials to access your dashboard</p>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <% if(request.getParameter("registered") != null) { %>
            <div class="alert alert-success">
                Registration successful! Please login.
            </div>
        <% } %>

        <form action="StudentServlet" method="post">
            <input type="hidden" name="action" value="login">
            
            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-input" placeholder="Enter your username" required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-input" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn-submit">Login</button>
        </form>

        <div class="footer-links">
            <a href="index.jsp">Back to Home</a>
            <a href="StudentServlet?action=new">Create Account</a>
        </div>
    </div>

    <script>
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

        document.addEventListener('mouseleave', () => {
            cursor.style.opacity = "0";
            ring.style.opacity = "0";
            document.body.style.cursor = "default";
        });

        document.addEventListener('mouseenter', () => {
            if(initialized) {
                cursor.style.opacity = "1";
                ring.style.opacity = "0.5";
            }
        });

        function animRing() {
            rx += (mx - rx) * 0.12;
            ry += (my - ry) * 0.12;
            ring.style.transform = `translate(${rx - 18}px, ${ry - 18}px)`;
            requestAnimationFrame(animRing);
        }
        animRing();
    </script>
</body>
</html>
