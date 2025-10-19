# Alternative Ways to Rebuild on cPanel

## Method 1: Build Locally + Upload (Recommended)

**Easiest and most reliable method:**

### On Your Computer:
```bash
# 1. Build the site
npm run build

# 2. Create ZIP
# Mac: Right-click 'out' folder → Compress
# Windows: Right-click 'out' folder → Send to → Compressed folder
```

### Upload to cPanel:
1. Login to cPanel File Manager
2. Go to `public_html`
3. Delete all files
4. Upload the ZIP file
5. Extract it
6. Move files from `out/` to root
7. Done! ✅

**Time:** 5-10 minutes

---

## Method 2: GitHub Actions (Automated)

**Set up once, then automatic deployment on every push!**

### Setup Steps:

1. **Add Secrets to GitHub:**
   - Go to: https://github.com/Nealjain/acm_test/settings/secrets/actions
   - Click "New repository secret"
   - Add these secrets:

   ```
   NEXT_PUBLIC_SUPABASE_URL
   Value: https://dhxzkzdlsszwuqjkicnv.supabase.co

   NEXT_PUBLIC_SUPABASE_ANON_KEY
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoeHpremRsc3N6d3VxamtpY252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNTYyNjksImV4cCI6MjA3MDgzMjI2OX0.ofq619iAaQPW33zm_6uG6-r9UDg6tU7EF8krqZWlLOs

   FTP_SERVER
   Value: ftp.acm.org (or your FTP hostname)

   FTP_USERNAME
   Value: your_cpanel_username

   FTP_PASSWORD
   Value: your_cpanel_password
   ```

2. **Push the workflow file:**
   ```bash
   git add .github/workflows/deploy-cpanel.yml
   git commit -m "Add GitHub Actions deployment"
   git push origin main
   ```

3. **Done!** Now every time you push to GitHub, it will:
   - Build the site automatically
   - Deploy to cPanel via FTP
   - Takes 3-5 minutes

### Manual Trigger:
- Go to: https://github.com/Nealjain/acm_test/actions
- Click "Deploy to cPanel"
- Click "Run workflow"

---

## Method 3: Vercel + Custom Domain

**Deploy to Vercel instead of cPanel (dynamic updates!):**

### Advantages:
- ✅ No rebuilding needed
- ✅ Database changes appear instantly
- ✅ Free hosting
- ✅ Automatic HTTPS
- ✅ Global CDN

### Setup:
1. Go to https://vercel.com
2. Import `Nealjain/acm_test` from GitHub
3. Add environment variables
4. Deploy
5. Add custom domain: `sakec.acm.org`
6. Update DNS in cPanel to point to Vercel

---

## Method 4: cPanel Cron Job (Scheduled Rebuilds)

**Automatically rebuild every night:**

### In cPanel:
1. Go to "Cron Jobs"
2. Add new cron job:
   - **Minute:** 0
   - **Hour:** 3
   - **Day:** *
   - **Month:** *
   - **Weekday:** *
   - **Command:**
   ```bash
   cd /home/sakechostingacm/repositories/acm_test && export NEXT_PUBLIC_SUPABASE_URL=https://dhxzkzdlsszwuqjkicnv.supabase.co && export NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoeHpremRsc3N6d3VxamtpY252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNTYyNjksImV4cCI6MjA3MDgzMjI2OX0.ofq619iAaQPW33zm_6uG6-r9UDg6tU7EF8krqZWlLOs && npm run build && rm -rf /home/sakechostingacm/public_html/* && cp -R out/* /home/sakechostingacm/public_html/
   ```

Site rebuilds automatically at 3 AM every day!

---

## Method 5: Webhook Trigger

**Rebuild when you click a button:**

### Create a PHP rebuild script:

Create `rebuild.php` in your repository:

```php
<?php
// rebuild.php - Trigger rebuild via URL
$secret = 'your_secret_key_here'; // Change this!

if ($_GET['secret'] !== $secret) {
    die('Unauthorized');
}

$output = shell_exec('cd /home/sakechostingacm/repositories/acm_test && export NEXT_PUBLIC_SUPABASE_URL=https://dhxzkzdlsszwuqjkicnv.supabase.co && export NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoeHpremRsc3N6d3VxamtpY252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNTYyNjksImV4cCI6MjA3MDgzMjI2OX0.ofq619iAaQPW33zm_6uG6-r9UDg6tU7EF8krqZWlLOs && npm run build && rm -rf /home/sakechostingacm/public_html/* && cp -R out/* /home/sakechostingacm/public_html/ 2>&1');

echo "<pre>$output</pre>";
echo "Rebuild complete!";
?>
```

Then visit: `http://sakec.acm.org/rebuild.php?secret=your_secret_key_here`

---

## Method 6: Use Netlify/Vercel Instead

**Best solution for dynamic content:**

Deploy to Vercel or Netlify instead of cPanel:
- No rebuilding needed
- Database changes appear instantly
- Free hosting
- Better performance

Point your domain to Vercel/Netlify instead of cPanel.

---

## Comparison Table

| Method | Difficulty | Speed | Auto Updates |
|--------|-----------|-------|--------------|
| Local Build + Upload | Easy | 5-10 min | ❌ Manual |
| GitHub Actions | Medium | 3-5 min | ✅ On push |
| Vercel | Easy | Instant | ✅ Always |
| Cron Job | Medium | Daily | ✅ Scheduled |
| Webhook | Medium | On demand | ✅ Click button |
| Terminal | Hard | 2-3 min | ❌ Manual |

---

## My Recommendation:

**For cPanel:** Use **GitHub Actions** (Method 2)
- Set up once
- Automatic deployment
- No manual work

**Better Option:** Use **Vercel** (Method 3)
- No rebuilding ever needed
- Database changes appear instantly
- Free and faster

---

Choose the method that works best for you!
