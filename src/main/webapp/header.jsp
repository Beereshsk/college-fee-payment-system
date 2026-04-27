<%-- header.jsp  - include at top of every page --%>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet"/>
<style>
/* 
   COLLEGE FEE PAYMENT SYSTEM - Global Styles
   Aesthetic: Deep Navy + Gold - Academic Prestige
 */
:root {
  --navy:      #0a1628;
  --navy2:     #112040;
  --navy3:     #1a2f55;
  --gold:      #c9a84c;
  --gold-lt:   #e4c46a;
  --gold-pale: #f5e9c8;
  --cream:     #faf8f2;
  --white:     #ffffff;
  --red:       #e05252;
  --green:     #2da55e;
  --orange:    #e08030;
  --text:      #1a2035;
  --muted:     #6b7a99;
  --border:    #d8dce8;
  --shadow:    0 4px 24px rgba(10,22,40,.12);
  --radius:    12px;
}

*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--cream);
  color: var(--text);
  min-height: 100vh;
}

/*  NAV  */
.topbar {
  background: var(--navy);
  padding: 0 2rem;
  display: flex;
  align-items: center;
  gap: 0;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 2px 20px rgba(0,0,0,.4);
}
.topbar-brand {
  font-family: 'Playfair Display', serif;
  color: var(--gold);
  font-size: 1.25rem;
  font-weight: 700;
  padding: 1rem 1.5rem 1rem 0;
  border-right: 1px solid rgba(201,168,76,.25);
  margin-right: 1rem;
  white-space: nowrap;
  text-decoration: none;
  letter-spacing: .02em;
}
.topbar-brand span { color: var(--white); }
.nav-links { display: flex; align-items: stretch; flex: 1; }
.nav-links a {
  color: rgba(255,255,255,.7);
  text-decoration: none;
  font-size: .85rem;
  font-weight: 500;
  padding: 0 1rem;
  display: flex;
  align-items: center;
  gap: .4rem;
  transition: color .2s, background .2s;
  letter-spacing: .03em;
  height: 56px;
  border-bottom: 3px solid transparent;
}
.nav-links a:hover, .nav-links a.active {
  color: var(--gold-lt);
  border-bottom-color: var(--gold);
  background: rgba(201,168,76,.07);
}
.nav-links .nav-icon { font-size: 1rem; }

/*  PAGE SHELL  */
.page-wrap {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2.5rem 1.5rem 4rem;
}

/*  PAGE HEADER  */
.page-header {
  background: linear-gradient(135deg, var(--navy) 0%, var(--navy3) 100%);
  border-radius: var(--radius);
  padding: 2rem 2.5rem;
  margin-bottom: 2rem;
  position: relative;
  overflow: hidden;
}
.page-header::before {
  content: '';
  position: absolute;
  right: -40px; top: -40px;
  width: 200px; height: 200px;
  border-radius: 50%;
  background: rgba(201,168,76,.08);
}
.page-header::after {
  content: '';
  position: absolute;
  right: 60px; bottom: -60px;
  width: 150px; height: 150px;
  border-radius: 50%;
  background: rgba(201,168,76,.05);
}
.page-header h1 {
  font-family: 'Playfair Display', serif;
  color: var(--white);
  font-size: 1.8rem;
  font-weight: 700;
  line-height: 1.2;
  position: relative;
}
.page-header p {
  color: rgba(255,255,255,.6);
  margin-top: .4rem;
  font-size: .9rem;
  position: relative;
}
.page-header .badge-gold {
  display: inline-block;
  background: var(--gold);
  color: var(--navy);
  font-size: .7rem;
  font-weight: 600;
  padding: .2rem .7rem;
  border-radius: 20px;
  letter-spacing: .06em;
  text-transform: uppercase;
  margin-bottom: .6rem;
}

/*  CARD  */
.card {
  background: var(--white);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  border: 1px solid var(--border);
  overflow: hidden;
}
.card-body { padding: 2rem 2.5rem; }

/*  FORM  */
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.2rem 2rem; }
@media(max-width:640px){ .form-grid{grid-template-columns:1fr} }
.form-group { display: flex; flex-direction: column; gap: .4rem; }
.form-group label {
  font-size: .78rem;
  font-weight: 600;
  color: var(--navy3);
  letter-spacing: .06em;
  text-transform: uppercase;
}
.form-group label .req { color: var(--red); margin-left:.2rem; }
.form-control {
  padding: .75rem 1rem;
  border: 1.5px solid var(--border);
  border-radius: 8px;
  font-size: .95rem;
  font-family: 'DM Sans', sans-serif;
  color: var(--text);
  background: #fafbfd;
  transition: border-color .2s, box-shadow .2s;
  outline: none;
}
.form-control:focus {
  border-color: var(--gold);
  box-shadow: 0 0 0 3px rgba(201,168,76,.15);
  background: var(--white);
}
select.form-control { cursor: pointer; }

/*  BUTTONS  */
.btn {
  display: inline-flex;
  align-items: center;
  gap: .5rem;
  padding: .75rem 1.75rem;
  border-radius: 8px;
  font-family: 'DM Sans', sans-serif;
  font-size: .9rem;
  font-weight: 600;
  cursor: pointer;
  border: 2px solid transparent;
  transition: all .2s;
  text-decoration: none;
  letter-spacing: .02em;
}
.btn-primary {
  background: var(--navy);
  color: var(--white);
  border-color: var(--navy);
}
.btn-primary:hover { background: var(--navy3); transform: translateY(-1px); box-shadow: 0 6px 18px rgba(10,22,40,.25); }
.btn-gold {
  background: var(--gold);
  color: var(--navy);
  border-color: var(--gold);
}
.btn-gold:hover { background: var(--gold-lt); transform: translateY(-1px); box-shadow: 0 6px 18px rgba(201,168,76,.35); }
.btn-danger {
  background: var(--red);
  color: var(--white);
  border-color: var(--red);
}
.btn-danger:hover { background: #c93a3a; transform: translateY(-1px); }
.btn-outline {
  background: transparent;
  color: var(--navy);
  border-color: var(--border);
}
.btn-outline:hover { border-color: var(--navy3); background: var(--navy); color: var(--white); }
.btn-sm { padding: .45rem 1rem; font-size: .82rem; }
.btn-row { display: flex; gap: 1rem; flex-wrap: wrap; margin-top: 1.5rem; }

/*  ALERTS  */
.alert {
  padding: 1rem 1.25rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  font-size: .9rem;
  display: flex;
  align-items: flex-start;
  gap: .6rem;
  font-weight: 500;
  line-height: 1.5;
}
.alert-error   { background: #fef0f0; border: 1.5px solid #f5c6c6; color: #8b1a1a; }
.alert-success { background: #f0faf4; border: 1.5px solid #9fd9ba; color: #1a5c37; }
.alert-info    { background: #f0f5ff; border: 1.5px solid #b3c9f5; color: #1a2d6b; }

/*  TABLE  */
.table-wrap { overflow-x: auto; }
table {
  width: 100%;
  border-collapse: collapse;
  font-size: .9rem;
}
thead tr { background: var(--navy); }
thead th {
  color: var(--gold-pale);
  font-family: 'DM Sans', sans-serif;
  font-size: .75rem;
  font-weight: 600;
  letter-spacing: .07em;
  text-transform: uppercase;
  padding: .9rem 1.2rem;
  white-space: nowrap;
  text-align: left;
}
tbody tr { border-bottom: 1px solid var(--border); transition: background .15s; }
tbody tr:hover { background: #f5f7ff; }
tbody td { padding: .85rem 1.2rem; vertical-align: middle; }

/*  STATUS BADGES  */
.badge {
  display: inline-block;
  padding: .25rem .75rem;
  border-radius: 20px;
  font-size: .75rem;
  font-weight: 600;
  letter-spacing: .04em;
  text-transform: uppercase;
}
.badge-paid    { background: #d4f3e4; color: #1a5c37; }
.badge-overdue { background: #fde8e8; color: #8b1a1a; }
.badge-pending { background: #fff3d4; color: #7a4a00; }

/*  STATS ROW  */
.stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
.stat-card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 1.25rem 1.5rem;
  text-align: center;
}
.stat-card .stat-val {
  font-family: 'Playfair Display', serif;
  font-size: 2rem;
  color: var(--navy);
  font-weight: 700;
}
.stat-card .stat-lbl { font-size: .75rem; color: var(--muted); font-weight: 500; letter-spacing: .05em; text-transform: uppercase; margin-top: .2rem; }

/*  DIVIDER  */
.divider { height:1px; background:var(--border); margin:1.5rem 0; }

/*  CONFIRM BOX  */
.confirm-box {
  background: #fff8f8;
  border: 2px solid #f5c6c6;
  border-radius: var(--radius);
  padding: 1.5rem 2rem;
  margin: 1.5rem 0;
}
.confirm-box h3 { color: var(--red); font-size: 1rem; margin-bottom: .75rem; display:flex;align-items:center;gap:.5rem; }
.confirm-box table { font-size: .9rem; }
.confirm-box td { padding: .3rem .8rem; }
.confirm-box td:first-child { font-weight: 600; color: var(--muted); width: 150px; }

/*  FOOTER  */
.site-footer {
  text-align: center;
  padding: 2rem;
  color: var(--muted);
  font-size: .8rem;
  border-top: 1px solid var(--border);
  margin-top: 3rem;
}
</style>
