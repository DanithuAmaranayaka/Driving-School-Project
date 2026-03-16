<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:if test="${student != null}">Edit Profile — DriveEase</c:if>
        <c:if test="${student == null}">Registration — DriveEase</c:if>
    </title>
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
            --input-bg: rgba(255, 255, 255, 0.03);
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
            overflow-x: hidden;
            min-height: 100vh;
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

        nav {
            padding: 24px 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border);
            background: rgba(10, 10, 15, 0.8);
            backdrop-filter: blur(10px);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
            color: var(--text);
        }
        .nav-logo span { color: var(--accent); }

        .container {
            max-width: 900px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .reg-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 48px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.5);
            animation: fadeUp 0.8s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section-header {
            margin-bottom: 40px;
        }
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .section-subtitle {
            color: var(--muted);
            font-weight: 300;
            font-size: 0.95rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .form-full { grid-column: span 2; }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-size: 0.8rem;
            color: var(--muted);
            font-weight: 600;
            letter-spacing: 0.02em;
        }

        input, select, textarea {
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 14px 18px;
            color: var(--text);
            font-family: inherit;
            font-size: 0.95rem;
            transition: all 0.3s;
            appearance: none;
            -webkit-appearance: none;
        }

        select {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%23e8c547' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: calc(100% - 18px) center;
            padding-right: 48px;
            cursor: pointer;
        }

        select option {
            background-color: var(--card);
            color: var(--text);
            padding: 12px;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 0 4px rgba(232, 197, 71, 0.1);
        }

        .divider {
            grid-column: span 2;
            height: 1px;
            background: var(--border);
            margin: 12px 0;
        }

        .login-info-title {
            grid-column: span 2;
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--accent);
            margin-top: 8px;
        }

        .btn-group {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 16px;
            margin-top: 32px;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            cursor: default;
        }

        .btn-ghost {
            color: var(--muted);
            border: 1.5px solid var(--border);
        }
        .btn-ghost:hover {
            color: var(--text);
            background: rgba(255,255,255,0.05);
            border-color: rgba(255,255,255,0.2);
        }

        .btn-primary {
            background: var(--accent);
            color: #0a0a0f;
            border: none;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(232, 197, 71, 0.2);
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-full { grid-column: span 1; }
            .divider, .login-info-title, .btn-group { grid-column: span 1; }
            .btn-group { flex-direction: column-reverse; }
            .btn { text-align: center; }
        }
    </style>
</head>
<body>

    <div class="cursor" id="cursor"></div>
    <div class="cursor-ring" id="cursorRing"></div>

    <nav>
        <a href="index.jsp" class="nav-logo">Drive<span>Ease</span></a>
        <c:if test="${sessionScope.adminUser != null}">
            <a href="AdminServlet?action=dashboard" class="btn btn-ghost" style="padding: 10px 20px; font-size: 0.8rem;">Admin Dashboard</a>
        </c:if>
    </nav>

    <div class="container">
        <div class="reg-card">
            <div class="section-header">
                <h1 class="section-title">
                    <c:if test="${student != null}">Update Profile</c:if>
                    <c:if test="${student == null}">Join DriveEase</c:if>
                </h1>
                <p class="section-subtitle">
                    <c:if test="${student != null}">Modify your student records below.</c:if>
                    <c:if test="${student == null}">Start your journey to becoming a confident driver today.</c:if>
                </p>
            </div>

            <c:if test="${student != null}">
                <form action="StudentServlet?action=update" method="post" class="form-grid">
            </c:if>
            <c:if test="${student == null}">
                <form action="StudentServlet?action=insert" method="post" class="form-grid">
            </c:if>
            
                <c:if test="${student != null}">
                    <input type="hidden" name="id" value="<c:out value='${student.studentId}' />" />
                </c:if>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" value="<c:out value='${student.name}' />" placeholder="John Doe" required>
                </div>

                <div class="form-group">
                    <label>NIC / ID Number</label>
                    <input type="text" name="nic" value="<c:out value='${student.nic}' />" placeholder="123456789V" required>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phoneNumber" value="<c:out value='${student.phoneNumber}' />" placeholder="+94 7X XXX XXXX" required>
                </div>

                <div class="form-group">
                    <label>License Category</label>
                    <select name="licenseType" required>
                        <option value="Car" <c:if test="${student.licenseType == 'Car'}">selected</c:if>>Car (B)</option>
                        <option value="Bike" <c:if test="${student.licenseType == 'Bike'}">selected</c:if>>Bike (A)</option>
                        <option value="Both" <c:if test="${student.licenseType == 'Both'}">selected</c:if>>Comprehensive (Car & Bike)</option>
                    </select>
                </div>

                <div class="form-group form-full">
                    <label>Residential Address</label>
                    <textarea name="address" rows="3" placeholder="Enter your current address" required><c:out value='${student.address}' /></textarea>
                </div>

                <c:if test="${student == null}">
                    <div class="divider"></div>
                    <div class="login-info-title">Account Security</div>
                    <div class="form-group">
                        <label>Portal Username</label>
                        <input type="text" name="username" placeholder="Choose a username" required>
                    </div>
                    <div class="form-group">
                        <label>Portal Password</label>
                        <input type="password" name="password" placeholder="Create a strong password" required>
                    </div>
                </c:if>

                <div class="btn-group">
                    <c:choose>
                        <c:when test="${sessionScope.adminUser != null}">
                            <a href="StudentServlet?action=list" class="btn btn-ghost">Cancel</a>
                        </c:when>
                        <c:otherwise>
                            <a href="index.jsp" class="btn btn-ghost">Cancel</a>
                        </c:otherwise>
                    </c:choose>
                    <button type="submit" class="btn btn-primary">
                        <c:if test="${student != null}">Save Changes</c:if>
                        <c:if test="${student == null}">Complete Registration</c:if>
                    </button>
                </div>
            </form>
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
