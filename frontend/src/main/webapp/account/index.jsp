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
            <h2 class="text-xl font-semibold mb-3">Total Balance</h2>
            <p class="text-4xl font-bold text-green-600" id="total-balance">LKR 152,000.00</p>
        </div>

        <div class="bg-white p-5 rounded-xl shadow-md">
            <h2 class="text-xl font-semibold mb-3">Fund Transfer</h2>
            <form class="space-y-2 flex flex-col" onsubmit="sendTransfer(event)">
                <div class="flex flex-col gap-y-1">
                    <label for="transfer-account-select" class="font-medium">Your Account *</label>
                    <select class="rounded-md px-3 py-2 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none capitalize"
                            required id="transfer-account-select" name="transferAccountSelect">
                        <option value="">Select Source Account</option>
                    </select>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="transfer-to-account-no" class="font-medium">Recipient Account Number *</label>
                    <input type="text" placeholder="Add Recipient Account Number" id="transfer-to-account-no"
                           name="transferToAccountNo"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required maxlength="13"/>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="transfer-amount" class="font-medium">Transfer Amount *</label>
                    <input type="number" placeholder="Amount (LKR)" id="transfer-amount" name="transferAmount"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required min="100"/>
                </div>
                <div class="flex gap-x-2 mt-2">
                    <button onclick="transferReset()"
                            class="bg-black flex-1 text-white font-medium py-1.5 rounded-md hover:bg-gray-800 cursor-pointer">
                        Reset
                    </button>
                    <button type="submit"
                            class="bg-[#16A34A] text-white font-medium py-1.5 flex-4 rounded-md hover:bg-[#28914e] cursor-pointer">
                        Transfer
                    </button>
                </div>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="transferMessageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="transferMessageList">
                    </ul>
                </div>
            </form>
        </div>

        <div class="bg-white p-5 rounded-xl shadow-md">
            <h2 class="text-xl font-semibold mb-3">Schedule Fund Transfer</h2>
            <form class="space-y-2 flex flex-col" onsubmit="sendScheduleTransfer(event)">
                <div class="flex flex-col gap-y-1">
                    <label for="scheduled-transfer-account-select" class="font-medium">Your Account *</label>
                    <select class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none capitalize"
                            required id="scheduled-transfer-account-select" name="scheduledAccountSelect">
                        <option value="">Select Source Account</option>
                    </select>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="scheduled-transfer-to-account-no" class="font-medium">Recipient Account Number *</label>
                    <input type="text" placeholder="Recipient Account Number" id="scheduled-transfer-to-account-no"
                           name="scheduledAccountNo"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required/>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="scheduled-transfer-amount" class="font-medium">Transfer Amount *</label>
                    <input type="number" placeholder="Amount (LKR)" id="scheduled-transfer-amount"
                           name="scheduledAmount"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required/>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="scheduled-transfer-date-time" class="font-medium">Transfer Date & Time</label>
                    <input type="datetime-local" id="scheduled-transfer-date-time" name="scheduledDate"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required/>
                </div>
                <div class="flex gap-x-2 mt-2">
                    <button onclick="scheduleTransferReset()"
                            class="bg-black flex-1 text-white font-medium py-1.5 rounded-md hover:bg-gray-800 cursor-pointer">
                        Reset
                    </button>
                    <button type="submit"
                            class="bg-yellow-400 text-white font-medium py-1.5 flex-4 rounded-md hover:bg-yellow-500 cursor-pointer">
                        Schedule
                    </button>
                </div>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="scheduledTransferMessageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="scheduledTransferMessageList">
                    </ul>
                </div>
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

        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-2">
            <div class="flex justify-between items-center px-3 py-2">
                <label for="accountList" class="mb-3 text-xl font-semibold">Balance History</label>
                <select class="rounded-md border-2 border-gray-300 px-3 py-2 w-sm capitalize outline-none hover:border-[#16A34A] active:border-[#16A34A]"
                        id="accountList" onchange="loadTransferHistory(event.target.value)">
                </select>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse" id="transferHistoryTable">
                    <thead>
                    <tr class="bg-gray-100">
                        <th class="p-2 border-b">Date</th>
                        <th class="p-2 border-b">Description</th>
                        <th class="p-2 border-b">Amount</th>
                        <th class="p-2 border-b">Balance</th>
                    </tr>
                    </thead>
                    <tbody id="table-body">
                    <tr id="table-row">
                        <td class="p-2 border-b" id="table-date">2025-07-01</td>
                        <td class="p-2 border-b" id="table-desc">Interest Credit</td>
                        <td class="p-2 border-b">
                            <span class="" id="table-amount">+LKR 1,200.00</span>
                        </td>
                        <td class="p-2 border-b" id="table-balance">LKR 152,000.00</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div id="transferHistoryError" class="w-full hidden">
            </div>
        </div>
    </main>
</div>

<div class="fixed inset-0 bg-black bg-opacity-20 flex items-center justify-center z-50 hidden" id="confirmModal">
    <div class="bg-white rounded-xl w-full max-w-md shadow-lg">
        <div class="bg-blue-700 text-white text-lg font-semibold px-6 py-4 rounded-t-xl">
            Confirm Transaction
        </div>
        <div class="px-6 py-4 space-y-2 text-gray-800">
            <div class="flex justify-between">
                <span class="font-semibold">Transfer Amount: </span>
                <span id="transfer-modal-amount" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">From Account: </span>
                <span id="transfer-modal-from-account-no" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">To Account: </span>
                <span id="transfer-modal-to-account-no" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">Recipient Name: </span>
                <span id="transfer-modal-to-name" class="font-medium capitalize"></span>
            </div>
        </div>
        <div class="flex flex-col gap-y-1 px-6 py-4" style="display: none;" id="transfer-modal-otp-view">
            <label for="transfer-modal-otp" class="font-medium">OTP *</label>
            <input type="text" placeholder="Enter OTP" id="transfer-modal-otp"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none w-full"
                   required/>
            <p class="text-sm text-gray-600 mb-3">An OTP has been sent to your registered mobile/email.</p>
        </div>
        <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
             id="transferModalMessageView" style="display: none;">
            <strong class="font-bold">Please correct the following errors:</strong>
            <ul class="list-disc ml-5 mt-2" id="transferModalMessageList">
            </ul>
        </div>
        <div class="px-6 py-4 bg-gray-100 rounded-b-xl flex justify-center space-x-4">
            <button class="font-medium py-2 px-6 rounded-md bg-gray-300 hover:bg-gray-400"
                    onclick="closeModal('confirmModal')">
                Cancel
            </button>
            <button class="bg-[#16A34A] text-white font-medium py-2 px-6 rounded-md hover:bg-[#28914e] cursor-pointer"
                    onclick="confirmTransfer()">
                Confirm
            </button>
        </div>
    </div>
</div>

<div class="fixed inset-0 bg-black bg-opacity-20 flex items-center justify-center z-50 hidden"
     id="confirmScheduleModal">
    <div class="bg-white rounded-xl w-full max-w-md shadow-lg">
        <div class="bg-blue-700 text-white text-lg font-semibold px-6 py-4 rounded-t-xl">
            Confirm Transaction
        </div>
        <div class="px-6 py-4 space-y-2 text-gray-800">
            <div class="flex justify-between">
                <span class="font-semibold">Transfer Amount: </span>
                <span id="scheduled-modal-amount" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">From Account: </span>
                <span id="scheduled-modal-from-account-no" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">To Account: </span>
                <span id="scheduled-modal-to-account-no" class="font-medium"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">Recipient Name: </span>
                <span id="scheduled-modal-to-name" class="font-medium capitalize"></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold">Scheduled At: </span>
                <span id="scheduled-modal-date" class="font-medium capitalize"></span>
            </div>
        </div>
        <div class="flex flex-col gap-y-1 px-6 py-4" style="display: none;" id="scheduled-modal-otp-view">
            <label for="scheduled-modal-otp" class="font-medium">OTP *</label>
            <input type="text" placeholder="Enter OTP" id="scheduled-modal-otp"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none w-full"
                   required/>
            <p class="text-sm text-gray-600 mb-3">An OTP has been sent to your registered mobile/email.</p>
        </div>
        <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
             id="scheduledModalMessageView" style="display: none;">
            <strong class="font-bold">Please correct the following errors:</strong>
            <ul class="list-disc ml-5 mt-2" id="scheduledModalMessageList">
            </ul>
        </div>
        <div class="px-6 py-4 bg-gray-100 rounded-b-xl flex justify-center space-x-4">
            <button class="font-medium py-2 px-6 rounded-md bg-gray-300 hover:bg-gray-400"
                    onclick="closeModal('confirmScheduleModal')">
                Cancel
            </button>
            <button class="bg-[#16A34A] text-white font-medium py-2 px-6 rounded-md hover:bg-[#28914e] cursor-pointer"
                    onclick="confirmScheduleTransfer()">
                Confirm
            </button>
        </div>
    </div>
</div>
</body>
</html>
