# How to Rebuild Site in cPanel

## When to Rebuild:
- ✅ After updating team members in database
- ✅ After changing events in database
- ✅ After updating blog posts
- ✅ After any database changes

## Method 1: Using the Rebuild Script (Easiest)

### Step 1: Upload Script to cPanel
1. Upload `rebuild-cpanel.sh` to `/home/sakechostingacm/`
2. In cPanel Terminal, make it executable:
```bash
chmod +x /home/sakechostingacm/rebuild-cpanel.sh
```

### Step 2: Run the Script
```bash
/home/sakechostingacm/rebuild-cpanel.sh
```

That's it! The script will:
- Pull latest code from GitHub
- Install dependencies
- Build the site
- Deploy to public_html

---

## Method 2: Manual Commands

### In cPanel Terminal:

```bash
# 1. Go to repository
cd /home/sakechostingacm/repositories/acm_test

# 2. Set environment variables
export NEXT_PUBLIC_SUPABASE_URL=https://dhxzkzdlsszwuqjkicnv.supabase.co
export NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoeHpremRsc3N6d3VxamtpY252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNTYyNjksImV4cCI6MjA3MDgzMjI2OX0.ofq619iAaQPW33zm_6uG6-r9UDg6tU7EF8krqZWlLOs

# 3. Pull latest changes (if you pushed to GitHub)
git pull origin main

# 4. Install dependencies (first time only)
npm install

# 5. Build the site
npm run build

# 6. Deploy to public_html
rm -rf /home/sakechostingacm/public_html/*
cp -R out/* /home/sakechostingacm/public_html/

# 7. Done!
echo "Site rebuilt and deployed!"
```

---

## Method 3: Using cPanel Git Deployment

If you set up Git Version Control in cPanel:

1. Push changes to GitHub from your local machine
2. In cPanel → Git Version Control
3. Click "Manage" on your repository
4. Click "Pull or Deploy"
5. Click "Deploy HEAD Commit"

The `.cpanel.yml` file will automatically:
- Install dependencies
- Build the site
- Copy files to public_html

---

## Troubleshooting

### Error: npm not found
```bash
# Use full path
/usr/local/bin/npm install
/usr/local/bin/npm run build
```

### Error: Permission denied
```bash
# Fix permissions
chmod -R 755 /home/sakechostingacm/repositories/acm_test
```

### Error: Out of memory
```bash
# Increase Node memory
export NODE_OPTIONS="--max-old-space-size=2048"
npm run build
```

### Build takes too long
- The first build takes 2-3 minutes
- Subsequent builds are faster (30-60 seconds)

---

## Quick Reference

**Repository Path:**
```
/home/sakechostingacm/repositories/acm_test
```

**Public HTML Path:**
```
/home/sakechostingacm/public_html/
```

**Build Command:**
```bash
npm run build
```

**Output Folder:**
```
out/
```

---

## Automated Rebuilds (Optional)

### Set up a Cron Job to rebuild daily:

1. In cPanel → Cron Jobs
2. Add new cron job:
   - Minute: 0
   - Hour: 2
   - Command: `/home/sakechostingacm/rebuild-cpanel.sh`

This will rebuild your site every day at 2 AM to fetch latest database changes.

---

## Need Help?

- Check cPanel error logs
- Contact your hosting provider
- Check Terminal output for errors

---

**Remember:** Every time you update the database, you need to rebuild the site for changes to appear!
