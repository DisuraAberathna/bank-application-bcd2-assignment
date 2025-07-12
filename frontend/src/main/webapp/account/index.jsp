<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/8/2025
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank | Account Dashboard</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script src="../public/js/account-dashboard.js"></script>
</head>
<body class="bg-gray-100 text-gray-900" onload="loadAccounts()">
<div class="min-h-screen flex flex-col">
    <!-- Navbar -->
    <header class="bg-blue-600 text-white p-4 shadow-md flex justify-between items-center">
        <div class="flex-2">
            <h1 class="text-2xl font-bold">Account Dashboard</h1>
        </div>
        <div class="flex items-center justify-between gap-x-8">
            <a href="${pageContext.request.contextPath}/auth/logout"
               class="text-white font-bold hover:text-gray-100 cursor-pointer text-xl flex item-center gap-x-2">
                <span class="material-symbols-outlined rotate-180">logout</span>
                <span class="hover:underline underline-offset-8">Logout</span>
            </a>
            <h1 class="text-xl font-bold capitalize flex item-center gap-x-2">
                <span class="material-symbols-outlined">account_circle</span>
                ${pageContext.request.userPrincipal.name}
            </h1>
        </div>
    </header>

    <main class="flex-1 p-6 grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
        <!-- Available Balance -->
        <div class="bg-white p-5 rounded-xl shadow-md">
            <h2 class="text-xl font-semibold mb-3">Available Balance</h2>
            <p class="text-4xl font-bold text-green-600">LKR 152,000.00</p>
        </div>

        <!-- Fund Transfer with Account Selection -->
        <div class="bg-white p-5 rounded-xl shadow-md">
            <h2 class="text-xl font-semibold mb-3">Fund Transfer</h2>
            <form class="space-y-3 flex flex-col" onsubmit="event.preventDefault(); openOtpModal();">
                <select class="rounded-md px-3 py-2 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none capitalize"
                        required id="transfer-account-select">
                    <option value="">Select Source Account</option>
                </select>
                <input type="text" placeholder="Recipient Account Number"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                       required maxlength="13"/>
                <input type="number" placeholder="Amount (LKR)"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                       required min="100"/>
                <button type="submit"
                        class="bg-[#16A34A] text-white font-medium py-1.5 w-full rounded-md hover:bg-[#28914e] cursor-pointer">
                    Transfer
                </button>
            </form>
        </div>

        <!-- Schedule Fund Transfer with Time + Account -->
        <div class="bg-white p-5 rounded-xl shadow-md">
            <h2 class="text-xl font-semibold mb-3">Schedule Fund Transfer</h2>
            <form class="space-y-3 flex flex-col">
                <select class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none capitalize"
                        required id="scheduled-transfer-account-select">
                    <option value="">Select Source Account</option>
                </select>
                <input type="text" placeholder="Recipient Account Number"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                       required/>
                <input type="number" placeholder="Amount (LKR)"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                       required/>
                <label class="block text-sm text-gray-600">Transfer Date & Time</label>
                <input type="datetime-local"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                       required/>
                <button type="submit"
                        class="bg-yellow-400 text-white font-medium py-1.5 w-full rounded-md hover:bg-yellow-500 cursor-pointer">
                    Schedule
                </button>
            </form>
        </div>

        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-2">
            <h2 class="text-xl font-semibold mb-3">Your Accounts</h2>
            <ul class="space-y-2" id="accounts">
                <li class="p-3 border rounded-lg flex justify-between" id="account">
                    <div>
                        <p class="font-semibold capitalize" id="account-type">Savings Account</p>
                        <p class="text-sm text-gray-600" id="account-no">Account No: ACC1001</p>
                    </div>
                    <p class="font-semibold text-green-600" id="account-balance">LKR 100,000.00</p>
                </li>
            </ul>
        </div>

        <!-- Balance History -->
        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-2">
            <h2 class="text-xl font-semibold mb-3">Balance History</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                    <tr class="bg-gray-100">
                        <th class="p-2 border-b">Date</th>
                        <th class="p-2 border-b">Description</th>
                        <th class="p-2 border-b">Amount</th>
                        <th class="p-2 border-b">Balance</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2 border-b">2025-07-01</td>
                        <td class="p-2 border-b">Interest Credit</td>
                        <td class="p-2 border-b">
                            <span class="text-green-600">+LKR 1,200.00</span>
                        </td>
                        <td class="p-2 border-b">LKR 152,000.00</td>
                    </tr>
                    <tr>
                        <td class="p-2 border-b">2025-06-28</td>
                        <td class="p-2 border-b">Fund Transfer to ACC1234</td>
                        <td class="p-2 border-b">
                            <span class="text-red-600">-LKR 10,000.00</span>
                        </td>
                        <td class="p-2 border-b">LKR 150,800.00</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<!-- OTP Modal -->
<div id="otpModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50 hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg w-80">
        <h3 class="text-lg font-semibold mb-4">Enter OTP</h3>
        <p class="text-sm text-gray-600 mb-3">An OTP has been sent to your registered mobile/email.</p>
        <input type="text" placeholder="Enter OTP" class="w-full p-2 border rounded mb-4"/>
        <div class="flex justify-end space-x-2">
            <button onclick="closeOtpModal()" class="font-medium py-1.5 px-4 rounded-md bg-gray-300 hover:bg-gray-400">
                Cancel
            </button>
            <button onclick="closeOtpModal()"
                    class="bg-[#16A34A] text-white font-medium py-1.5 px-4 rounded-md hover:bg-[#28914e] cursor-pointer">
                Confirm
            </button>
        </div>
    </div>
</div>

<!-- Modal background overlay -->
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden" id="confirmModal">
    <!-- Modal container -->
    <div class="bg-white rounded-xl w-full max-w-md shadow-lg">
        <!-- Modal Header -->
        <div class="bg-blue-700 text-white text-lg font-semibold px-6 py-4 rounded-t-xl">
            Confirm Transaction
        </div>

        <!-- Modal Body -->
        <div class="px-6 py-4 space-y-2 text-gray-800">
            <div class="flex justify-between">
                <span class="font-medium">Transfer Amount:</span>
                <span>LKR 1000</span>
            </div>
            <div class="flex justify-between">
                <span class="font-medium">From Account:</span>
                <span>397521358</span>
            </div>
            <div class="flex justify-between">
                <span class="font-medium">To Account:</span>
                <span>983542818</span>
            </div>
            <div class="flex justify-between">
                <span class="font-medium">Recipient Name:</span>
                <span>Heshan Bandar</span>
            </div>
        </div>

        <!-- Modal Footer -->
        <div class="px-6 py-4 bg-gray-100 rounded-b-xl flex justify-center space-x-4">
            <button class="bg-teal-500 hover:bg-teal-600 text-white px-6 py-2 rounded-md">
                Cancel
            </button>
            <button class="bg-teal-500 hover:bg-teal-600 text-white px-6 py-2 rounded-md">
                Confirm
            </button>
        </div>
    </div>
</div>
</body>
</html>
