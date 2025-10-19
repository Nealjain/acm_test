#!/bin/bash
# Rebuild and Deploy Script for cPanel

echo "========================================="
echo "  SAKEC ACM Website - Rebuild & Deploy"
echo "========================================="
echo ""

# Set environment variables
export NEXT_PUBLIC_SUPABASE_URL=https://dhxzkzdlsszwuqjkicnv.supabase.co
export NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRoeHpremRsc3N6d3VxamtpY252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUyNTYyNjksImV4cCI6MjA3MDgzMjI2OX0.ofq619iAaQPW33zm_6uG6-r9UDg6tU7EF8krqZWlLOs

# Navigate to repository
cd /home/sakechostingacm/repositories/acm_test || exit

echo "📥 Pulling latest changes from GitHub..."
git pull origin main

echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "🔨 Building the site..."
npm run build

echo ""
echo "🚀 Deploying to public_html..."
rm -rf /home/sakechostingacm/public_html/*
cp -R out/* /home/sakechostingacm/public_html/

echo ""
echo "✅ Deployment complete!"
echo "🌐 Visit: http://sakec.acm.org"
echo ""
echo "========================================="
