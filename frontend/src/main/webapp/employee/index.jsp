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
</head>
<body class="bg-gray-100 text-gray-900">
<div class="min-h-screen flex flex-col">
    <!-- Navbar -->
    <header class="bg-indigo-600 text-white p-4 shadow-md flex justify-between items-center">
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
        <!-- Add New Customer Account -->
        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-1">
            <h2 class="text-xl font-semibold mb-3">Add New Customer Account</h2>
            <form class="space-y-3 flex flex-col" id="addCustomerForm">
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
                        <input type="text" name="nic" id="nic" placeholder="Enter NIC Number" maxlength="10"
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

        <!-- View All Customer Accounts -->
        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-2">
            <h2 class="text-xl font-semibold mb-3">Customer Accounts</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                    <tr class="bg-gray-100">
                        <th class="p-2 border-b">Customer Name</th>
                        <th class="p-2 border-b">Account No</th>
                        <th class="p-2 border-b">Type</th>
                        <th class="p-2 border-b">Balance</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2 border-b">Disura Aberathna</td>
                        <td class="p-2 border-b">ACC1001</td>
                        <td class="p-2 border-b">Savings</td>
                        <td class="p-2 border-b">
                            <span class="text-green-600">LKR 100,000.00</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="p-2 border-b">Sanduni Perera</td>
                        <td class="p-2 border-b">ACC1002</td>
                        <td class="p-2 border-b">Current</td>
                        <td class="p-2 border-b">
                            <span class="text-green-600">LKR 52,000.00</span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- View Transaction Histories -->
        <div class="bg-white p-5 rounded-xl shadow-md md:col-span-3">
            <h2 class="text-xl font-semibold mb-3">Transaction Histories</h2>
            <form class="mb-4">
                <input type="text" placeholder="Search by Account Number..."
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none w-full md:w-1/3"/>
            </form>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                    <tr class="bg-gray-100">
                        <th class="p-2 border-b">Date</th>
                        <th class="p-2 border-b">Account No</th>
                        <th class="p-2 border-b">Description</th>
                        <th class="p-2 border-b">Amount</th>
                        <th class="p-2 border-b">Balance</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="p-2 border-b">2025-07-01</td>
                        <td class="p-2 border-b">ACC1001</td>
                        <td class="p-2 border-b">Interest Credit</td>
                        <td class="p-2 border-b">
                            <span class="text-green-600">+LKR 1,200.00</span>
                        </td>
                        <td class="p-2 border-b">LKR 100,000.00</td>
                    </tr>
                    <tr>
                        <td class="p-2 border-b">2025-06-28</td>
                        <td class="p-2 border-b">ACC1002</td>
                        <td class="p-2 border-b">Transfer to ACC1234</td>
                        <td class="p-2 border-b">
                            <span class="text-red-600">-LKR 10,000.00</span>
                        </td>
                        <td class="p-2 border-b">LKR 52,000.00</td>
                    </tr>
                    <!-- Additional rows can be dynamically loaded -->
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
<script>
    document.getElementById("addCustomerForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        const form = e.target;

        const formData = {
            "firstName": form.firstName.value,
            "lastName": form.lastName.value,
            "email": form.email.value,
            "mobile": form.mobile.value,
            "nic": form.nic.value,
            "deposit": form.deposit.value,
            "type": form.type.value,
            "exists": form.useExists.checked,
        };

        document.getElementById("messageList").innerHTML = "";
        document.getElementById("messageView").style.display = "none";

        try {
            const response = await fetch("${pageContext.request.contextPath}/add-customer", {
                method: "POST",
                body: JSON.stringify(formData),
            });

            const data = await response.json();

            if (data.success) {
                document.getElementById("messageView").style.display = "none";
                document.getElementById("useExistsView").style.display = "none";

                alert(data.message);
                form.reset();
            } else {
                if (data.existsCustomer) {
                    document.getElementById("useExistsView").style.display = "block";
                    alert(data.warning);
                } else {
                    const messageList = document.getElementById("messageList");
                    for (const [field, message] of Object.entries(data.errors)) {
                        const li = document.createElement("li");
                        li.textContent = message;
                        li.classList.add("max-w-sm");
                        messageList.appendChild(li);
                    }

                    document.getElementById("messageView").style.display = "block";
                }
            }
        } catch (error) {
            console.error("Error:", error);
            const messageList = document.getElementById("messageList");
            const li = document.createElement("li");
            li.textContent = "An unexpected error occurred.";
            li.classList.add("max-w-sm");
            messageList.appendChild(li);
            document.getElementById("messageView").style.display = "block";
        }
    });
</script>
</body>
</html>
