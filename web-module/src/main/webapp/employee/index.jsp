<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/8/2025
  Time: 3:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>National Bank | Employee Dashboard</title>
    <link rel="stylesheet" href="../public/css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script src="../public/js/common.js"></script>
    <script src="../public/js/employee-dashboard.js"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-green-50">
<div class="min-h-screen flex flex-col">
    <header class="bg-white/80 backdrop-blur-md border-b border-neutral-200 shadow-sm sticky top-0 z-40">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-4">
                    <div class="w-10 h-10 bg-gradient-to-br from-green-500 to-green-600 rounded-xl flex items-center justify-center shadow-lg">
                        <span class="material-symbols-outlined text-white text-xl">account_balance</span>
                    </div>
                    <div>
                        <h1 class="text-xl font-bold text-display text-gradient">Employee Dashboard</h1>
                        <p class="text-sm text-neutral-600">Manage customers and accounts</p>
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

    <main class="p-6 grid grid-cols-1 lg:grid-cols-2 gap-6 max-w-7xl mx-auto w-full">
        <div class="card rounded-xl border border-slate-200 p-6 shadow-xl md:col-span-1">
            <h2 class="mb-3 text-xl font-semibold text-neutral-800">Add New Customer Account</h2>
            <form class="flex flex-col space-y-3" id="addCustomerForm" onsubmit="addCustomer(event)">
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="firstName" class="form-label">First Name *</label>
                        <input type="text" name="firstName" id="firstName" placeholder="Enter First Name"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="lastName" class="form-label">Last Name *</label>
                        <input type="text" name="lastName" id="lastName" placeholder="Enter Last Name"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                    </div>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="email" class="form-label">Email Address *</label>
                    <input type="email" name="email" id="email" placeholder="Enter Email Address"
                           class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                </div>
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="mobile" class="form-label">Mobile Number *</label>
                        <input type="tel" name="mobile" id="mobile" placeholder="Enter Mobile Number" maxlength="10"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="nic" class="form-label">NIC Number *</label>
                        <input type="text" name="nic" id="nic" placeholder="Enter NIC Number" maxlength="12"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                    </div>
                </div>
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="deposit" class="form-label">Initial Deposit (LKR) *</label>
                        <input type="number" name="deposit" id="deposit" placeholder="Enter Initial Deposit (LKR)"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required min="1000"/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="type" class="form-label">Account Type (LKR) *</label>
                        <select class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required name="type"
                                id="type">
                            <option value="">Select Account Type</option>
                            <option value="savings">Savings</option>
                            <option value="current">Current</option>
                            <option value="deposit">Deposit</option>
                        </select>
                    </div>
                </div>
                <div class="flex gap-x-2 px-3 py-1 items-center" id="useExistsView" style="display: none;">
                    <input type="checkbox" id="useExists" name="useExists"
                           class="w-4 h-4 rounded-xl border-2 border-gray-300 outline-none active:border-[#16A34A]"/>
                    <label for="useExists" class="cursor-pointer font-normal select-none">Use Existing Customer
                        Account</label>
                </div>
                <button type="submit"
                        class="btn bg-gradient-to-tr from-green-500 to-green-600 flex justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white">
                    <span class="material-symbols-outlined mr-2 text-sm">person_add</span>
                    Create Account
                </button>
                <div class="relative mt-3 rounded-lg border-2 border-red-400 bg-red-100 px-4 py-3 text-red-700"
                     id="messageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="mt-2 ml-5 list-disc" id="messageList"></ul>
                </div>
            </form>
        </div>

        <div class="space-y-6">
            <div class="card rounded-xl border border-slate-200 p-6 shadow-lg md:col-span-1">
                <h2 class="mb-3 text-xl font-semibold text-neutral-800">Search Customer Account</h2>
                <div class="flex items-end justify-between px-4 py-2 gap-x-3">
                    <div class="flex flex-3 flex-col gap-y-1">
                        <label for="s-nic" class="form-label">NIC Number *</label>
                        <input type="text" id="s-nic" placeholder="Customer NIC"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required/>
                    </div>
                    <div class="flex-1">
                        <button class="btn bg-gradient-to-tr from-green-500 to-green-600 flex justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white"
                                onclick="loadCustomer()">
                            Search
                        </button>
                    </div>
                </div>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="s-messageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="s-messageList">
                    </ul>
                </div>
            </div>

            <div class="card rounded-xl border border-slate-200 p-6 shadow-lg md:col-span-1">
                <h2 class="mb-3 text-xl font-semibold text-neutral-800">Search Fund Transfer History</h2>
                <div class="flex items-end justify-between px-4 py-2 gap-x-3">
                    <div class="flex flex-3 flex-col gap-y-1">
                        <label for="t-accNo" class="form-label">Account Number *</label>
                        <input type="text" id="t-accNo" placeholder="Customer Account Number"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                               required/>
                    </div>
                    <div class="flex-1">
                        <button class="btn bg-gradient-to-tr from-green-500 to-green-600 flex justify-center items-center cursor-pointer w-full rounded-xl py-3 text-white"
                                onclick="loadTransferHistory()">
                            Search
                        </button>
                    </div>
                </div>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="t-messageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="t-messageList">
                    </ul>
                </div>
            </div>
        </div>

        <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
            <div class="card rounded-xl border border-slate-200 p-6 shadow-lg md:col-span-1">
                <h2 class="mb-3 text-xl font-semibold text-neutral-800">Add New Employee Account</h2>
                <form class="flex flex-col space-y-3" onsubmit="addEmployee(event)">
                    <div class="flex w-full items-center justify-between gap-x-3">
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empFirstName" class="form-label">First Name *</label>
                            <input type="text" name="empFirstName" id="empFirstName" placeholder="Enter First Name"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                        </div>
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empLastName" class="form-label">Last Name *</label>
                            <input type="text" name="empLastName" id="empLastName" placeholder="Enter Last Name"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                        </div>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="empEmail" class="form-label">Email Address *</label>
                        <input type="email" name="empEmail" id="empEmail" placeholder="Enter Email Address"
                               class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                    </div>
                    <div class="flex w-full items-center justify-between gap-x-3">
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empMobile" class="form-label">Mobile Number *</label>
                            <input type="tel" name="empMobile" id="empMobile" placeholder="Enter Mobile Number"
                                   maxlength="10" class="form-input rounded-lg border-2 border-stone-400 px-3 py-2"
                                   required/>
                        </div>
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empUsername" class="form-label">Username *</label>
                            <input type="text" name="empUserName" id="empUsername" placeholder="Enter Username"
                                   class="form-input rounded-lg border-2 border-stone-400 px-3 py-2" required/>
                        </div>
                    </div>
                    <button type="submit"
                            class="btn flex w-full cursor-pointer items-center justify-center rounded-xl bg-gradient-to-tr from-green-500 to-green-600 py-3 text-white">
                        <span class="material-symbols-outlined mr-2 text-sm">person_add</span>
                        Add Employee
                    </button>
                    <div class="relative mt-3 rounded-lg border-2 border-red-400 bg-red-100 px-4 py-3 text-red-700"
                         id="empMessageView" style="display: none;">
                        <strong class="font-bold">Please correct the following errors:</strong>
                        <ul class="mt-2 ml-5 list-disc" id="empMessageList"></ul>
                    </div>
                </form>
            </div>
        </c:if>

        <div class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center hidden"
             id="customerDetailsModal">
            <div class="relative w-full max-w-2xl rounded-2xl bg-white p-6 shadow-2xl animate-scale-in">
                <button class="absolute top-4 right-4 h-8 w-8 cursor-pointer rounded-full text-xl font-bold text-gray-800 hover:bg-neutral-100"
                        onclick="closeAccountModal()">
                    &times;
                </button>

                <h2 class="mb-4 text-xl font-semibold">Customer Details & History</h2>

                <div class="mb-4">
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Name :</span> <span
                            id="c-name"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Email Address :</span> <span
                            id="c-email"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">NIC Number :</span> <span
                            id="c-nic"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Mobile Number :</span> <span
                            id="c-mobile"></span></p>
                </div>

                <div class="mb-6">
                    <p class="mb-2 font-semibold">Accounts:</p>
                    <div class="overflow-x-auto">
                        <table class="min-w-full border text-sm">
                            <thead class="bg-neutral-50">
                            <tr>
                                <th class="border px-4 py-2 text-left">Account No</th>
                                <th class="border px-4 py-2 text-left">Type</th>
                                <th class="border px-4 py-2 text-left">Balance</th>
                                <th class="border px-4 py-2 text-left">Last Transaction</th>
                            </tr>
                            </thead>
                            <tbody id="c-tbody">
                            <tr id="c-trow">
                                <td class="border px-4 py-2" id="c-accNo">ACC100001</td>
                                <td class="border px-4 py-2 capitalize" id="c-type">Savings</td>
                                <td class="border px-4 py-2" id="c-balance">LKR 50,000</td>
                                <td class="border px-4 py-2" id="c-lTransaction">2025-07-05</td>
                            </tr>
                            <tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="hidden">
                    <h3 class="mb-2 text-lg font-semibold">Update Customer</h3>
                    <form class="space-y-3">
                        <input type="text" placeholder="1234"
                               class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
                        <input type="text" placeholder="Akila Heshan"
                               class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
                        <input type="email" placeholder="akila@email.com"
                               class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
                        <input type="text" placeholder="0777123456"
                               class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
                        <button type="submit"
                                class="w-full cursor-pointer rounded-md bg-[#16A34A] py-1.5 font-medium text-white hover:bg-[#28914e]">
                            Update Info
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center hidden"
             id="transferHistoryModal">
            <div class="relative w-full max-w-4xl rounded-2xl bg-white p-6 shadow-2xl animate-scale-in">
                <button class="absolute top-4 right-4 h-8 w-8 cursor-pointer rounded-full text-xl font-bold text-gray-800 hover:bg-neutral-100"
                        onclick="closeTransferHistoryModal()">
                    &times;
                </button>

                <h2 class="mb-4 text-xl font-semibold">Fund Transfer History</h2>

                <div class="mb-4">
                    <p><span class="font-semibold">Account Number :</span> <span id="tm-accNo"></span></p>
                </div>

                <div class="mb-5 overflow-x-auto">
                    <table class="min-w-full border text-sm">
                        <thead>
                        <tr class="bg-neutral-50">
                            <th class="border px-4 py-2 text-left">Date</th>
                            <th class="border px-4 py-2 text-left">Description</th>
                            <th class="border px-4 py-2 text-left">Amount</th>
                            <th class="border px-4 py-2 text-left">Balance</th>
                        </tr>
                        </thead>
                        <tbody id="table-body">
                        <tr id="table-row">
                            <td class="border px-4 py-2" id="table-date">2025-07-01</td>
                            <td class="border px-4 py-2" id="table-desc">Interest Credit</td>
                            <td class="border px-4 py-2">
                                <span class="" id="table-amount">+LKR 1,200.00</span>
                            </td>
                            <td class="border px-4 py-2" id="table-balance">LKR 152,000.00</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
