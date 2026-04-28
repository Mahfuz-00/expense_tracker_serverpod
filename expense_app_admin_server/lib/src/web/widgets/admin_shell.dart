import 'package:serverpod/serverpod.dart';

class AdminShell extends WebWidget {
  final String title;
  final String content;
  final String activePage;

  AdminShell({required this.title, required this.content, required this.activePage});

  @override
  String toString() {
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Expense Admin | $title</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap">
    <style>
        :root {
            --primary: #6366f1;
            --bg: #f8fafc;
            --sidebar: #0f172a;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); color: var(--text-main); display: flex; min-height: 100vh; }
        
        .sidebar { width: 280px; background: var(--sidebar); color: white; display: flex; flex-direction: column; position: fixed; height: 100vh; }
        .logo { padding: 2rem; font-size: 1.5rem; font-weight: 700; color: white; display: flex; align-items: center; gap: 10px; }
        .logo span { color: var(--primary); }
        .nav { flex: 1; padding: 0 1rem; }
        .nav-item { 
            display: flex; align-items: center; padding: 0.8rem 1.2rem; color: #94a3b8; 
            text-decoration: none; border-radius: 12px; margin-bottom: 0.5rem; transition: all 0.2s; font-weight: 500;
        }
        .nav-item:hover { background: rgba(255,255,255,0.05); color: white; }
        .nav-item.active { background: var(--primary); color: white; box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3); }

        .main { flex: 1; margin-left: 280px; padding: 2.5rem; }
        .header { margin-bottom: 2.5rem; }
        
        /* DASHBOARD UI FIXES */
        .info-box { background: white; padding: 1.5rem; border-radius: 16px; border: 1px solid var(--border); }
        .info-box h3 { font-size: 0.875rem; color: var(--text-muted); margin-bottom: 0.5rem; }
        .info-box .val { font-size: 1.5rem; font-weight: 700; }
        
        .card-white { background: white; padding: 1.5rem; border-radius: 16px; border: 1px solid var(--border); }
        
        .mini-card { 
            background: white; padding: 1rem; border-radius: 12px; border: 1px solid var(--border); 
            margin-bottom: 0.75rem; display: flex; justify-content: space-between; align-items: center;
        }
        .cat-label { font-weight: 600; font-size: 0.9rem; }
        .cat-amt { color: var(--primary); font-weight: 700; }
        .scroll-stack { max-height: 400px; overflow-y: auto; padding-right: 5px; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #fcfcfd; padding: 1rem; text-align: left; font-size: 0.75rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; border-bottom: 1px solid var(--border); }
        td { padding: 1.2rem 1rem; border-bottom: 1px solid var(--border); font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">🚀 <span>Expense</span>App</div>
        <nav class="nav">
            <a href="/" class="nav-item ${activePage == 'dash' ? 'active' : ''}">Dashboard</a>
            <a href="/users" class="nav-item ${activePage == 'users' ? 'active' : ''}">Users</a>
            <a href="/expenses" class="nav-item ${activePage == 'exp' ? 'active' : ''}">Expenses</a>
            <a href="/settings" class="nav-item ${activePage == 'set' ? 'active' : ''}">Settings</a>
        </nav>
    </div>
    <div class="main">
        <div class="header"><h1>$title</h1></div>
        <div class="content-wrapper">$content</div>
    </div>
</body>
</html>
    ''';
  }
}