# cPanel Deployment Guide for SAKEC ACM Website

## Prerequisites
- cPanel access for sakec.acm.org
- FTP credentials (optional, for faster upload)

## Quick Deployment Steps

### Step 1: Build the Static Site

Run this command in your project directory:

```bash
npm run build
```

This creates an `out` folder with all static files ready for deployment.

### Step 2: Upload to cPanel

#### Option A: Using cPanel File Manager (Recommended for beginners)

1. **Login to cPanel**
   - Go to your cPanel URL
   - Enter your credentials

2. **Open File Manager**
   - Find "File Manager" in cPanel
   - Click to open

3. **Navigate to public_html**
   - Go to `/home/sakechostingacm/public_html/`

4. **Backup existing files (if any)**
   - Select all files
   - Click "Compress" to create a backup
   - Download the backup

5. **Clear the directory**
   - Select all files in public_html
   - Click "Delete"

6. **Upload new files**
   - Click "Upload" button
   - Select ALL files from your local `out` folder
   - Wait for upload to complete (may take 5-10 minutes)

#### Option B: Using FTP (Faster for large files)

1. **Download FileZilla** (or any FTP client)
   - https://filezilla-project.org/

2. **Connect to your server**
   - Host: `ftp.acm.org` (or provided FTP hostname)
   - Username: Your cPanel username
   - Password: Your cPanel password
   - Port: 21

3. **Navigate to public_html**
   - Remote site: `/home/sakechostingacm/public_html/`

4. **Upload files**
   - Local site: Navigate to your `out` folder
   - Select all files and folders
   - Drag to remote site
   - Wait for transfer to complete

#### Option C: Using ZIP Upload (Fastest)

1. **Create a ZIP file**
   - On Mac: Right-click `out` folder → Compress
   - On Windows: Right-click `out` folder → Send to → Compressed folder

2. **Upload ZIP to cPanel**
   - In cPanel File Manager
   - Navigate to `public_html`
   - Click "Upload"
   - Upload the ZIP file

3. **Extract the ZIP**
   - Right-click the uploaded ZIP
   - Select "Extract"
   - Move all extracted files to `public_html` root
   - Delete the ZIP file

### Step 3: Verify Deployment

1. **Check .htaccess**
   - Make sure `.htaccess` file is in `public_html`
   - It should be visible in File Manager (enable "Show Hidden Files")

2. **Set Permissions**
   - Files: 644
   - Folders: 755
   - (Usually set automatically)

3. **Test the website**
   - Visit: `http://sakec.acm.org`
   - Test navigation and links
   - Check all pages load correctly

## Important Files to Upload

Make sure these are in `public_html`:

```
public_html/
├── .htaccess          (routing and performance)
├── index.html         (homepage)
├── 404.html           (error page)
├── _next/             (JavaScript and CSS)
│   ├── static/
│   └── ...
├── about.html
├── blog.html
├── blog/              (blog posts)
├── contact.html
├── events.html
├── events/            (event pages)
├── gallery.html
├── team.html
├── team/              (team member pages)
├── why-join.html
└── [all image files]
```

## Environment Variables

Your Supabase credentials are already built into the static files during build time. No need to configure them in cPanel.

## Troubleshooting

### Issue: 404 errors on page refresh
**Solution:** Make sure `.htaccess` is uploaded and in the root of `public_html`

### Issue: Images not loading
**Solution:** Check that all files from `_next/static/` folder are uploaded

### Issue: Styles not working
**Solution:** Clear browser cache and check that CSS files in `_next/static/css/` are uploaded

### Issue: Links not working
**Solution:** Verify `.htaccess` has correct rewrite rules

## Performance Optimization

The `.htaccess` file includes:
- ✅ Gzip compression
- ✅ Browser caching
- ✅ HTTPS redirect
- ✅ Proper MIME types

## Updating the Website

To update the website:

1. Make changes to your code locally
2. Run `npm run build`
3. Upload only changed files from the new `out` folder
4. Or upload everything to replace all files

## Git Deployment (Alternative)

If you prefer automated deployment:

1. Set up Git Version Control in cPanel
2. Connect to: `https://github.com/Nealjain/acm_test.git`
3. The `.cpanel.yml` file will handle automatic deployment
4. Click "Deploy HEAD Commit" after each push

## Support

For issues:
- Check cPanel error logs
- Contact your hosting provider
- Check browser console for JavaScript errors

## Site URL

Your website will be live at:
**http://sakec.acm.org** (or https:// if SSL is configured)

---

**Last Updated:** October 19, 2025
**Build Command:** `npm run build`
**Output Directory:** `out/`
