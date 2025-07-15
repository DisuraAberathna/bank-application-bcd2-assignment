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
<body class="bg-gray-100 text-gray-900">
<div class="min-h-screen flex flex-col">
    <header class="bg-gradient-to-r from-[#16A34A] to-[#182e20] text-white p-4 shadow-md flex justify-between items-center">
        <div class="flex-2">
            <h1 class="text-2xl font-bold">Employee Dashboard</h1>
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
        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-1">
            <h2 class="text-xl font-semibold mb-3">Add New Customer Account</h2>
            <form class="space-y-3 flex flex-col" id="addCustomerForm" onsubmit="addCustomer(event)">
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="firstName" class="font-medium">First Name *</label>
                        <input type="text" name="firstName" id="firstName" placeholder="Enter First Name"
                               class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                               required/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="lastName" class="font-medium">Last Name *</label>
                        <input type="text" name="lastName" id="lastName" placeholder="Enter Last Name"
                               class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                               required/>
                    </div>
                </div>
                <div class="flex flex-col gap-y-1">
                    <label for="email" class="font-medium">Email Address *</label>
                    <input type="email" name="email" id="email" placeholder="Enter Email Address"
                           class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                           required/>
                </div>
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="mobile" class="font-medium">Mobile Number *</label>
                        <input type="tel" name="mobile" id="mobile" placeholder="Enter Mobile Number" maxlength="10"
                               class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                               required/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="nic" class="font-medium">NIC Number *</label>
                        <input type="text" name="nic" id="nic" placeholder="Enter NIC Number" maxlength="12"
                               class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                               required/>
                    </div>
                </div>
                <div class="flex w-full items-center justify-between gap-x-3">
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="deposit" class="font-medium">Initial Deposit (LKR) *</label>
                        <input type="number" name="deposit" id="deposit" placeholder="Enter Initial Deposit (LKR)"
                               class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                               required min="1000"/>
                    </div>
                    <div class="flex flex-1 flex-col gap-y-1">
                        <label for="type" class="font-medium">Account Type (LKR) *</label>
                        <select class="rounded-md px-3 py-2 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                required name="type" id="type">
                            <option value="">Select Account Type</option>
                            <option value="savings">Savings</option>
                            <option value="current">Current</option>
                            <option value="deposit">Deposit</option>
                        </select>
                    </div>
                </div>
                <div class="flex gap-x-2 px-3 py-1" id="useExistsView" style="display: none;">
                    <input type="checkbox" id="useExists" name="useExists"
                           class="rounded-lg border-2 border-gray-300 outline-none w-4 active:border-[#16A34A]"/>
                    <label for="useExists" class="font-normal cursor-pointer select-none">Use Existing Customer
                        Account</label>
                </div>
                <button type="submit"
                        class="bg-[#16A34A] text-white font-medium py-1.5 w-full rounded-md hover:bg-[#28914e] cursor-pointer">
                    Create Account
                </button>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="messageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="messageList">
                    </ul>
                </div>
            </form>
        </div>

        <div class="rounded-xl bg-white p-5 shadow-md md:col-span-1 h-fit">
            <h2 class="mb-3 text-xl font-semibold">Search Customer Account</h2>
            <div class="flex items-end justify-between px-4 py-2 gap-x-3">
                <div class="flex flex-3 flex-col gap-y-1">
                    <label for="s-nic" class="font-medium">NIC *</label>
                    <input type="text" id="s-nic" placeholder="Customer NIC"
                           class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"
                           required/>
                </div>
                <div class="flex-1">
                    <button class="w-full cursor-pointer rounded-md bg-[#16A34A] py-1.5 font-medium text-white hover:bg-[#28914e]"
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

        <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
            <div class="bg-white p-5 rounded-xl shadow-md md:col-span-1">
                <h2 class="text-xl font-semibold mb-3">Add New Employee Account</h2>
                <form class="space-y-3 flex flex-col" id="addEmployeeForm">
                    <div class="flex w-full items-center justify-between gap-x-3">
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empFirstName" class="font-medium">First Name *</label>
                            <input type="text" name="empFirstName" id="empFirstName" placeholder="Enter First Name"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empLastName" class="font-medium">Last Name *</label>
                            <input type="text" name="empLastName" id="empLastName" placeholder="Enter Last Name"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                    </div>
                    <div class="flex w-full items-center justify-between gap-x-3">
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empEmail" class="font-medium">Email Address *</label>
                            <input type="email" name="empEmail" id="empEmail" placeholder="Enter Email Address"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empMobile" class="font-medium">Mobile Number *</label>
                            <input type="tel" name="empMobile" id="empMobile" placeholder="Enter Mobile Number"
                                   maxlength="10"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                    </div>
                    <div class="flex w-full items-center justify-between gap-x-3">
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empUsername" class="font-medium">Username *</label>
                            <input type="text" name="empUserName" id="empUsername" placeholder="Enter Username"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                        <div class="flex flex-1 flex-col gap-y-1">
                            <label for="empPassword" class="font-medium">Password *</label>
                            <input type="text" name="empPassword" id="empPassword" placeholder="Enter Password"
                                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                                   required/>
                        </div>
                    </div>
                    <button type="submit"
                            class="bg-[#16A34A] text-white font-medium py-1.5 w-full rounded-md hover:bg-[#28914e] cursor-pointer">
                        Add Employee
                    </button>
                    <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                         id="empMessageView" style="display: none;">
                        <strong class="font-bold">Please correct the following errors:</strong>
                        <ul class="list-disc ml-5 mt-2" id="empMessageList">
                        </ul>
                    </div>
                </form>
            </div>
        </c:if>

        <!-- View Transaction Histories -->
        <div class="rounded-xl bg-white p-5 shadow-md md:col-span-3">
            <div class="mb-4 flex items-center justify-between">
                <div class="flex-2/4">
                    <h2 class="text-xl font-semibold">Transaction Histories</h2>
                </div>
                <div class="flex flex-1/4 gap-x-3">
                    <div class="flex-2/4">
                        <input type="text" placeholder="Search by Account Number..."
                               class="w-full rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
                    </div>
                    <div class="flex-1">
                        <button class="w-full cursor-pointer rounded-md bg-[#16A34A] py-1.5 font-medium text-white hover:bg-[#28914e]">
                            Search
                        </button>
                    </div>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-left">
                    <thead>
                    <tr class="bg-gray-100">
                        <th class="border-b p-2">Date</th>
                        <th class="border-b p-2">Account No</th>
                        <th class="border-b p-2">Description</th>
                        <th class="border-b p-2">Amount</th>
                        <th class="border-b p-2">Balance</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="border-b p-2">2025-07-01</td>
                        <td class="border-b p-2">ACC1001</td>
                        <td class="border-b p-2">Interest Credit</td>
                        <td class="border-b p-2">
                            <span class="text-green-600">+LKR 1,200.00</span>
                        </td>
                        <td class="border-b p-2">LKR 100,000.00</td>
                    </tr>
                    <tr>
                        <td class="border-b p-2">2025-06-28</td>
                        <td class="border-b p-2">ACC1002</td>
                        <td class="border-b p-2">Transfer to ACC1234</td>
                        <td class="border-b p-2">
                            <span class="text-red-600">-LKR 10,000.00</span>
                        </td>
                        <td class="border-b p-2">LKR 52,000.00</td>
                    </tr>
                    <!-- Additional rows can be dynamically loaded -->
                    </tbody>
                </table>
            </div>
        </div>

        <div class="bg-opacity-50 fixed inset-0 z-50 flex items-center justify-center bg-black hidden"
             id="customerDetailsModal">
            <div class="relative w-full max-w-2xl rounded-lg bg-white p-6 shadow-lg">
                <button class="absolute top-4 right-4 h-8 w-8 cursor-pointer rounded-full text-xl font-bold text-gray-800 hover:bg-gray-100"
                        onclick="closeModal('customerDetailsModal')">
                    &times;
                </button>

                <h2 class="mb-4 text-xl font-semibold">Customer Details & History</h2>

                <div class="mb-4">
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Name :</span> <span id="c-name"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Email Address :</span> <span id="c-email"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">NIC Number :</span> <span id="c-nic"></span></p>
                    <p class="flex item-center gap-x-2"><span class="font-semibold">Mobile Number :</span> <span id="c-mobile"></span></p>
                </div>

                <div class="mb-6">
                    <p class="mb-2 font-semibold">Accounts:</p>
                    <div class="overflow-x-auto">
                        <table class="min-w-full border text-sm">
                            <thead class="bg-gray-100">
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
    </main>
</div>
</body>
</html>
