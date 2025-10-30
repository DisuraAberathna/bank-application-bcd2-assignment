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
    <script src="../public/js/common.js"></script>
    <script src="../public/js/account-dashboard.js"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 via-blue-50 to-green-50 min-h-screen" onload="loadAccounts()">
<div class="min-h-screen flex flex-col">
    <!-- Modern Header -->
    <header class="bg-white/80 backdrop-blur-md border-b border-neutral-200 shadow-sm sticky top-0 z-40">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-4">
                    <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-xl flex items-center justify-center shadow-lg">
                        <span class="material-symbols-outlined text-white text-xl">account_balance</span>
                    </div>
                    <div>
                        <h1 class="text-xl font-bold text-display text-gradient">Account Dashboard</h1>
                        <p class="text-sm text-neutral-600">Manage your finances</p>
                    </div>
                </div>
                <div class="flex items-center space-x-6">
                    <div class="flex items-center space-x-3 bg-neutral-100 rounded-full px-4 py-2">
                        <span class="material-symbols-outlined text-green-600">account_circle</span>
                        <span class="font-medium text-neutral-800 capitalize">${pageContext.request.userPrincipal.name}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/auth/logout"
                       class="btn btn-outline text-red-600 border-red-300 hover:bg-red-50 hover:border-red-400 px-4 py-2 flex">
                        <span class="material-symbols-outlined text-sm mr-2">logout</span>
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="flex-1 p-6 max-w-7xl mx-auto w-full">
        <!-- Welcome Section -->
        <div class="mb-8 animate-fade-in">
            <h2 class="text-3xl font-bold text-display text-neutral-800 mb-2">Welcome
                back, ${pageContext.request.userPrincipal.name}!</h2>
            <p class="text-neutral-600">Here's an overview of your accounts and recent activity</p>
        </div>

        <!-- Stats Grid -->
        <div class="mb-8 grid grid-cols-1 gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="card card-hover animate-slide-up rounded-xl border-2 border-green-400 bg-gradient-to-br from-green-500/30 to-green-600/10 p-6 shadow">
                <div class="mb-4 flex items-center justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-green-500 to-green-600">
                        <span class="material-symbols-outlined text-xl text-white">account_balance_wallet</span>
                    </div>
                    <span class="text-sm text-neutral-500">Total Balance</span>
                </div>
                <h3 class="mb-1 text-3xl font-bold text-green-600" id="total-balance">LKR 0.00</h3>
                <p class="text-sm text-neutral-600">Across all accounts</p>
            </div>

            <div class="card card-hover animate-slide-up rounded-xl border-2 border-blue-400 bg-gradient-to-br from-blue-500/30 to-blue-600/10 p-6 shadow">
                <div class="mb-4 flex items-center justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-blue-500 to-blue-600">
                        <span class="material-symbols-outlined text-xl text-white">swap_horiz</span>
                    </div>
                    <span class="text-sm text-neutral-500">This Month</span>
                </div>
                <h3 class="mb-1 text-2xl font-bold text-blue-600">0</h3>
                <p class="text-sm text-neutral-600">Transactions</p>
            </div>

            <div class="card card-hover animate-slide-up rounded-xl border-2 border-purple-400 bg-gradient-to-br from-purple-500/30 to-purple-600/10 p-6 shadow">
                <div class="mb-4 flex items-center justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-purple-500 to-purple-600">
                        <span class="material-symbols-outlined text-xl text-white">savings</span>
                    </div>
                    <span class="text-sm text-neutral-500">Savings</span>
                </div>
                <h3 class="mb-1 text-2xl font-bold text-purple-600">0</h3>
                <p class="text-sm text-neutral-600">Accounts</p>
            </div>

            <div class="card card-hover animate-slide-up rounded-xl border-2 border-orange-400 bg-gradient-to-br from-orange-500/30 to-orange-600/10 p-6 shadow">
                <div class="mb-4 flex items-center justify-between">
                    <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-orange-500 to-orange-600">
                        <span class="material-symbols-outlined text-xl text-white">schedule</span>
                    </div>
                    <span class="text-sm text-neutral-500">Scheduled</span>
                </div>
                <h3 class="mb-1 text-2xl font-bold text-orange-600">0</h3>
                <p class="text-sm text-neutral-600">Transfers</p>
            </div>
        </div>
        
        <!-- Main Content Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            <!-- Fund Transfer Card -->
            <div class="card card-hover p-6 animate-slide-up rounded-xl border border-slate-200 p-6 shadow-xl">
                <div class="flex items-center mb-6">
                    <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-xl flex items-center justify-center mr-3">
                        <span class="material-symbols-outlined text-white">swap_horiz</span>
                    </div>
                    <h2 class="text-xl font-semibold text-neutral-800">Quick Transfer</h2>
                </div>

                <form class="space-y-4" onsubmit="sendTransfer(event)">
                    <div class="flex flex-col space-y-2">
                        <label for="transfer-account-select" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">account_balance</span>
                            Source Account *
                        </label>
                        <select class="form-input capitalize rounded-lg border-2 border-stone-400 px-3 py-2" required
                                id="transfer-account-select" name="transferAccountSelect">
                            <option value="">Select your account</option>
                        </select>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <label for="transfer-to-account-no" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">person</span>
                            Recipient Account *
                        </label>
                        <input type="text"
                               placeholder="Enter recipient account number"
                               id="transfer-to-account-no"
                               name="transferToAccountNo"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required maxlength="13"/>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <label for="transfer-amount" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">payments</span>
                            Amount (LKR) *
                        </label>
                        <input type="number"
                               placeholder="Enter amount"
                               id="transfer-amount"
                               name="transferAmount"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required min="100"/>
                    </div>

                    <div class="flex gap-3 pt-2">
                        <button type="button"
                                onclick="transferReset()"
                                class="btn bg-black flex flex-1 justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white">
                            <span class="material-symbols-outlined text-sm mr-2">refresh</span>
                            Reset
                        </button>
                        <button type="submit"
                                class="btn bg-gradient-to-tr from-blue-500 to-blue-600 flex flex-2 justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white">
                            <span class="material-symbols-outlined text-sm mr-2">send</span>
                            Transfer Now
                        </button>
                    </div>

                    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg hidden"
                         id="transferMessageView">
                        <div class="flex items-start">
                            <span class="material-symbols-outlined text-red-500 mr-2 mt-0.5">error</span>
                            <div>
                                <strong class="font-semibold">Please correct the following errors:</strong>
                                <ul class="list-disc ml-5 mt-2 space-y-1" id="transferMessageList">
                                </ul>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Schedule Transfer Card -->
            <div class="card card-hover p-6 animate-slide-up rounded-xl border border-slate-200 p-6 shadow-xl">
                <div class="flex items-center mb-6">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl flex items-center justify-center mr-3">
                        <span class="material-symbols-outlined text-white">schedule</span>
                    </div>
                    <h2 class="text-xl font-semibold text-neutral-800">Schedule Transfer</h2>
                </div>

                <form class="space-y-4" onsubmit="sendScheduleTransfer(event)">
                    <div class="flex flex-col space-y-2">
                        <label for="scheduled-transfer-account-select" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">account_balance</span>
                            Source Account *
                        </label>
                        <select class="form-input capitalize rounded-lg border-2 border-stone-400 px-3 py-2" required
                                id="scheduled-transfer-account-select" name="scheduledAccountSelect">
                            <option value="">Select your account</option>
                        </select>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <label for="scheduled-transfer-to-account-no" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">person</span>
                            Recipient Account *
                        </label>
                        <input type="text"
                               placeholder="Enter recipient account number"
                               id="scheduled-transfer-to-account-no"
                               name="scheduledAccountNo"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required/>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <label for="scheduled-transfer-amount" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">payments</span>
                            Amount (LKR) *
                        </label>
                        <input type="number"
                               placeholder="Enter amount"
                               id="scheduled-transfer-amount"
                               name="scheduledAmount"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required/>
                    </div>

                    <div class="flex flex-col space-y-2">
                        <label for="scheduled-transfer-date-time" class="form-label flex">
                            <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">schedule</span>
                            Schedule Date & Time *
                        </label>
                        <input type="datetime-local"
                               id="scheduled-transfer-date-time"
                               name="scheduledDate"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required/>
                    </div>

                    <div class="flex gap-3 pt-2">
                        <button type="button"
                                onclick="scheduleTransferReset()"
                                class="btn bg-black flex flex-1 justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white">
                            <span class="material-symbols-outlined text-sm mr-2">refresh</span>
                            Reset
                        </button>
                        <button type="submit"
                                class="btn bg-gradient-to-tr from-green-500 to-green-600 flex flex-2 justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white">
                            <span class="material-symbols-outlined text-sm mr-2">schedule</span>
                            Schedule
                        </button>
                    </div>

                    <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg hidden"
                         id="scheduledTransferMessageView">
                        <div class="flex items-start">
                            <span class="material-symbols-outlined text-red-500 mr-2 mt-0.5">error</span>
                            <div>
                                <strong class="font-semibold">Please correct the following errors:</strong>
                                <ul class="list-disc ml-5 mt-2 space-y-1" id="scheduledTransferMessageList">
                                </ul>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Accounts Section -->
            <div class="card card-hover p-6 xl:col-span-3 animate-slide-up">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl flex items-center justify-center mr-3">
                            <span class="material-symbols-outlined text-white">account_balance</span>
                        </div>
                        <h2 class="text-xl font-semibold text-neutral-800">Your Accounts</h2>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4" id="accounts">
                    <div class="bg-gradient-to-br from-green-50 to-green-100 border border-green-200 rounded-xl p-4"
                         id="account">
                        <div class="flex items-center justify-between mb-3">
                            <div class="w-8 h-8 bg-green-500 rounded-lg flex items-center justify-center">
                                <span class="material-symbols-outlined text-white text-sm">savings</span>
                            </div>
                            <span class="text-xs bg-green-200 text-green-800 px-2 py-1 rounded-full font-medium capitalize"
                                  id="account-type">Savings</span>
                        </div>
                        <div class="space-y-1">
                            <p class="text-sm text-neutral-600" id="account-no">ACC1001</p>
                            <p class="text-2xl font-bold text-green-600" id="account-balance">LKR 100,000.00</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Transaction History Section -->
            <div class="card card-hover p-6 xl:col-span-3 animate-slide-up">
                <div class="flex items-center justify-between mb-6">
                    <div class="flex items-center">
                        <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl flex items-center justify-center mr-3">
                            <span class="material-symbols-outlined text-white">history</span>
                        </div>
                        <h2 class="text-xl font-semibold text-neutral-800">Transaction History</h2>
                    </div>
                    <div class="flex items-center space-x-3">
                        <label for="accountList" class="text-sm font-medium text-neutral-700">Filter by account:</label>
                        <select class="form-input rounded-lg border-2 border-stone-400 px-3 py-2 capitalize"
                                id="accountList" onchange="loadTransferHistory(event.target.value)">
                            <option value="">All Accounts</option>
                        </select>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left" id="transferHistoryTable">
                        <thead>
                        <tr class="bg-neutral-50 border-b border-neutral-200">
                            <th class="px-4 py-3 text-sm font-semibold text-neutral-700">Date</th>
                            <th class="px-4 py-3 text-sm font-semibold text-neutral-700">Description</th>
                            <th class="px-4 py-3 text-sm font-semibold text-neutral-700">Amount</th>
                            <th class="px-4 py-3 text-sm font-semibold text-neutral-700">Balance</th>
                        </tr>
                        </thead>
                        <tbody id="table-body" class="divide-y divide-neutral-200">
                        <tr id="table-row" class="hover:bg-neutral-50 transition-colors">
                            <td class="px-4 py-3 text-sm text-neutral-600" id="table-date">2025-07-01</td>
                            <td class="px-4 py-3 text-sm font-medium text-neutral-800" id="table-desc">Interest Credit
                            </td>
                            <td class="px-4 py-3 text-sm font-semibold text-green-600" id="table-amount">+LKR 1,200.00
                            </td>
                            <td class="px-4 py-3 text-sm font-medium text-neutral-800" id="table-balance">LKR
                                152,000.00
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div id="transferHistoryError" class="hidden mt-4 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
                    <div class="flex items-center">
                        <span class="material-symbols-outlined text-yellow-600 mr-2">info</span>
                        <p class="text-yellow-800 text-sm">No transaction history available for the selected
                            account.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Transfer Confirmation Modal -->
<div class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 hidden" id="confirmModal">
    <div class="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-scale-in">
        <div class="bg-gradient-to-r from-green-600 to-green-700 text-white px-6 py-5 rounded-t-2xl">
            <div class="flex items-center">
                <div class="w-10 h-10 bg-white/20 rounded-xl flex items-center justify-center mr-3">
                    <span class="material-symbols-outlined text-white">security</span>
                </div>
                <h3 class="text-lg font-semibold">Confirm Transaction</h3>
            </div>
        </div>

        <div class="px-6 py-6 space-y-4">
            <div class="space-y-3">
                <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                    <span class="text-sm font-medium text-neutral-600">Transfer Amount</span>
                    <span id="transfer-modal-amount" class="text-lg font-bold text-green-600"></span>
                </div>
                <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                    <span class="text-sm font-medium text-neutral-600">From Account</span>
                    <span id="transfer-modal-from-account-no" class="text-sm font-medium text-neutral-800"></span>
                </div>
                <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                    <span class="text-sm font-medium text-neutral-600">To Account</span>
                    <span id="transfer-modal-to-account-no" class="text-sm font-medium text-neutral-800"></span>
                </div>
                <div class="flex justify-between items-center py-2">
                    <span class="text-sm font-medium text-neutral-600">Recipient Name</span>
                    <span id="transfer-modal-to-name" class="text-sm font-medium text-neutral-800 capitalize"></span>
                </div>
            </div>

            <div class="hidden" id="transfer-modal-otp-view">
                <div class="space-y-2">
                    <label for="transfer-modal-otp" class="form-label">
                        <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">key</span>
                        OTP Verification *
                    </label>
                    <input type="text"
                           placeholder="Enter OTP"
                           id="transfer-modal-otp"
                           class="form-input"
                           required/>
                    <p class="text-sm text-neutral-600 flex items-center">
                        <span class="material-symbols-outlined text-sm mr-1">info</span>
                        An OTP has been sent to your registered mobile/email
                    </p>
                </div>
            </div>

            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg hidden"
                 id="transferModalMessageView">
                <div class="flex items-start">
                    <span class="material-symbols-outlined text-red-500 mr-2 mt-0.5">error</span>
                    <div>
                        <strong class="font-semibold">Please correct the following errors:</strong>
                        <ul class="list-disc ml-5 mt-2 space-y-1" id="transferModalMessageList">
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="px-6 py-4 bg-neutral-50 rounded-b-2xl flex justify-center space-x-3">
            <button class="btn btn-secondary px-6 py-2"
                    onclick="closeModal('confirmModal')">
                Cancel
            </button>
            <button class="btn btn-primary px-6 py-2"
                    onclick="confirmTransfer()">
                <span class="material-symbols-outlined text-sm mr-2">check</span>
                Confirm Transfer
            </button>
        </div>
    </div>
</div>

<div class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 hidden"
     id="confirmScheduleModal">
    <div class="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-scale-in">
        <div class="bg-gradient-to-r from-green-600 to-green-700 text-white px-6 py-5 rounded-t-2xl">
            <div class="flex items-center">
                <div class="w-10 h-10 bg-white/20 rounded-xl flex items-center justify-center mr-3">
                    <span class="material-symbols-outlined text-white">schedule</span>
                </div>
                <h3 class="text-lg font-semibold">Confirm Scheduled Transfer</h3>
            </div>
        </div>
        <div class="px-6 py-6 space-y-4 text-neutral-800">
            <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                <span class="text-sm font-medium text-neutral-600">Transfer Amount</span>
                <span id="scheduled-modal-amount" class="text-lg font-bold text-green-600"></span>
            </div>
            <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                <span class="text-sm font-medium text-neutral-600">From Account</span>
                <span id="scheduled-modal-from-account-no" class="text-sm font-medium"></span>
            </div>
            <div class="flex justify-between items-center py-2 border-b border-neutral-100">
                <span class="text-sm font-medium text-neutral-600">To Account</span>
                <span id="scheduled-modal-to-account-no" class="text-sm font-medium"></span>
            </div>
            <div class="flex justify-between items-center py-2">
                <span class="text-sm font-medium text-neutral-600">Recipient Name</span>
                <span id="scheduled-modal-to-name" class="text-sm font-medium capitalize"></span>
            </div>
            <div class="flex justify-between items-center py-2">
                <span class="text-sm font-medium text-neutral-600">Scheduled At</span>
                <span id="scheduled-modal-date" class="text-sm font-medium"></span>
            </div>
            <div class="hidden" id="scheduled-modal-otp-view">
                <label for="scheduled-modal-otp" class="form-label">
                    <span class="material-symbols-outlined text-neutral-500 text-sm mr-2">key</span>
                    OTP *
                </label>
                <input type="text" placeholder="Enter OTP" id="scheduled-modal-otp"
                       class="form-input" required/>
                <p class="text-sm text-neutral-600">An OTP has been sent to your registered mobile/email.</p>
            </div>
            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg hidden"
                 id="scheduledModalMessageView">
                <div class="flex items-start">
                    <span class="material-symbols-outlined text-red-500 mr-2 mt-0.5">error</span>
                    <div>
                        <strong class="font-semibold">Please correct the following errors:</strong>
                        <ul class="list-disc ml-5 mt-2" id="scheduledModalMessageList"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="px-6 py-4 bg-neutral-50 rounded-b-2xl flex justify-center space-x-3">
            <button class="btn btn-secondary px-6 py-2" onclick="closeModal('confirmScheduleModal')">Cancel</button>
            <button class="btn btn-primary px-6 py-2" onclick="confirmScheduleTransfer()">
                <span class="material-symbols-outlined text-sm mr-2">check</span>
                Confirm
            </button>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 hidden" id="successModal">
    <div class="w-full max-w-md rounded-2xl bg-white shadow-2xl animate-scale-in">
        <div class="bg-gradient-to-r from-green-600 to-green-700 text-white px-6 py-5 rounded-t-2xl">
            <div class="flex items-center">
                <div class="w-10 h-10 bg-white/20 rounded-xl flex items-center justify-center mr-3">
                    <span class="material-symbols-outlined text-white">check_circle</span>
                </div>
                <h3 class="text-lg font-semibold" id="successModalTitle">Success!</h3>
            </div>
        </div>

        <div class="flex flex-col items-center justify-center gap-y-4 px-6 py-8">
            <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center">
                <span class="material-symbols-outlined text-green-600 text-4xl">check_circle</span>
            </div>
            <p class="text-center text-neutral-600" id="successModalDesc">Transaction completed successfully!</p>
        </div>

        <div class="px-6 pb-6 text-center">
            <button class="btn btn-primary px-8 py-3 rounded-xl"
                    onclick="successModal()">
                <span class="material-symbols-outlined text-sm mr-2">done</span>
                Continue
            </button>
        </div>
    </div>
</div>

</body>
</html>
