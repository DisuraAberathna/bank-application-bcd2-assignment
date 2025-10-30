<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/5/2025
  Time: 12:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank - Modern Banking Solutions</title>
    <link rel="stylesheet" href="./public/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body class="bg-gradient-to-br from-slate-50 via-blue-50 to-green-50 min-h-screen">
    <!-- Modern Navigation -->
    <header class="fixed w-full top-0 z-50 bg-white/80 backdrop-blur-md border-b border-neutral-200 shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-xl flex items-center justify-center shadow-lg">
                        <span class="material-symbols-outlined text-white text-xl">account_balance</span>
                    </div>
                    <h1 class="text-2xl font-bold text-display text-gradient">National Bank</h1>
                </div>
                <nav class="hidden md:flex items-center space-x-8">
                    <a href="${pageContext.request.contextPath}/auth/login.jsp"
                       class="text-neutral-700 hover:text-green-600 font-medium transition-colors duration-200 relative group px-4 py-1 rounded-lg">
                        Login
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/register.jsp"
                       class="btn btn-primary px-6 py-2.5 rounded-full shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200">
                        Get Started
                    </a>
                </nav>
                <!-- Mobile menu button -->
                <button class="md:hidden p-2 rounded-lg text-neutral-700 hover:bg-neutral-100 transition-colors">
                    <span class="material-symbols-outlined">menu</span>
                </button>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <main class="pt-16 min-h-screen">
        <section class="relative overflow-hidden">
            <!-- Background Elements -->
            <div class="absolute inset-0 bg-gradient-to-br from-green-400/10 via-blue-400/5 to-purple-400/10"></div>
            <div class="absolute top-20 left-10 w-72 h-72 bg-green-300/20 rounded-full blur-3xl animate-pulse"></div>
            <div class="absolute bottom-20 right-10 w-96 h-96 bg-blue-300/20 rounded-full blur-3xl animate-pulse delay-1000"></div>
            
            <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <div class="text-center animate-fade-in">
                    <div class="inline-flex items-center px-4 py-2 rounded-full bg-green-100 text-green-800 text-sm font-medium mb-8 animate-slide-up">
                        <span class="material-symbols-outlined text-green-600 mr-2">security</span>
                        Trusted by 1M+ customers worldwide
                    </div>
                    
                    <h1 class="text-5xl md:text-7xl font-bold text-display mb-6 animate-slide-up">
                        <span class="text-gradient">Modern Banking</span><br>
                        <span class="text-neutral-800">Made Simple</span>
                    </h1>
                    
                    <p class="text-xl text-neutral-600 mb-12 max-w-3xl mx-auto leading-relaxed animate-slide-up">
                        Experience the future of banking with our cutting-edge platform. 
                        Secure, fast, and designed for the modern world.
                    </p>
                    
                    <div class="flex flex-col sm:flex-row gap-4 justify-center items-center animate-scale-in">
                        <a href="${pageContext.request.contextPath}/auth/register.jsp"
                           class="btn btn-primary px-8 py-4 text-lg rounded-full shadow-xl hover:shadow-2xl transform hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto flex">
                            <span class="material-symbols-outlined mr-2">person_add</span>
                            Create Account
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/login.jsp"
                           class="btn btn-secondary px-8 py-4 text-lg rounded-full shadow-xl hover:shadow-2xl transform hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto flex">
                            <span class="material-symbols-outlined mr-2">login</span>
                            Sign In
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-20 bg-white/50 backdrop-blur-sm">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-4xl font-bold text-display text-neutral-800 mb-4">Why Choose National Bank?</h2>
                    <p class="text-xl text-neutral-600 max-w-2xl mx-auto">Experience banking like never before with our innovative features</p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="card card-hover p-8 text-center group">
                        <div class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
                            <span class="material-symbols-outlined text-white text-2xl">security</span>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-800 mb-4">Bank-Grade Security</h3>
                        <p class="text-neutral-600">Your data is protected with enterprise-level encryption and security protocols.</p>
                    </div>
                    
                    <div class="card card-hover p-8 text-center group">
                        <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
                            <span class="material-symbols-outlined text-white text-2xl">speed</span>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-800 mb-4">Lightning Fast</h3>
                        <p class="text-neutral-600">Process transactions in seconds with our optimized infrastructure.</p>
                    </div>
                    
                    <div class="card card-hover p-8 text-center group">
                        <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
                            <span class="material-symbols-outlined text-white text-2xl">support_agent</span>
                        </div>
                        <h3 class="text-xl font-semibold text-neutral-800 mb-4">24/7 Support</h3>
                        <p class="text-neutral-600">Get help whenever you need it with our round-the-clock customer support.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="py-20 bg-gradient-to-r from-green-600 to-green-700 text-white">
            <div class="max-w-4xl mx-auto text-center px-4 sm:px-6 lg:px-8">
                <h2 class="text-4xl font-bold text-display mb-6">Ready to Get Started?</h2>
                <p class="text-xl mb-8 opacity-90">Join thousands of satisfied customers and experience modern banking today.</p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="${pageContext.request.contextPath}/auth/register.jsp"
                       class="btn bg-white text-green-600 hover:bg-green-50 px-8 py-4 text-lg rounded-full shadow-xl hover:shadow-2xl transform hover:-translate-y-1 transition-all duration-300 flex">
                        <span class="material-symbols-outlined mr-2">rocket_launch</span>
                        Start Your Journey
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/login.jsp"
                       class="btn border-2 border-white text-white hover:bg-white hover:text-green-600 px-8 py-4 text-lg rounded-full transition-all duration-300 flex">
                        <span class="material-symbols-outlined mr-2">login</span>
                        Sign In
                    </a>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="bg-neutral-900 text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <div class="flex items-center justify-center space-x-3 mb-6">
                    <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-xl flex items-center justify-center">
                        <span class="material-symbols-outlined text-white text-xl">account_balance</span>
                    </div>
                    <h3 class="text-2xl font-bold text-display">National Bank</h3>
                </div>
                <p class="text-neutral-400 mb-6">© 2025 National Bank. All rights reserved.</p>
                <div class="flex justify-center space-x-6 text-sm text-neutral-400">
                    <a href="#" class="hover:text-white transition-colors">Privacy Policy</a>
                    <a href="#" class="hover:text-white transition-colors">Terms of Service</a>
                    <a href="#" class="hover:text-white transition-colors">Contact Us</a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
