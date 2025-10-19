/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export', // Static export for cPanel
  trailingSlash: true, // Better compatibility with cPanel
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    unoptimized: true, // Required for static export
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'dhxzkzdlsszwuqjkicnv.supabase.co',
        pathname: '/storage/v1/object/public/**',
      },
    ],
  },
  
  // Enable React strict mode for better performance
  reactStrictMode: true,
  
  // Optimize page transitions
  experimental: {
    optimizePackageImports: ['lucide-react', '@radix-ui/react-icons'],
  },
}

export default nextConfig
