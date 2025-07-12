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
            <form class="space-y-3 flex flex-col" id="fundTransferForm">
                <div class="flex flex-col gap-y-1">
                    <label for="transfer-account-select" class="font-medium">Select your account *</label>
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
                <button type="submit"
                        class="bg-[#16A34A] text-white font-medium py-1.5 w-full rounded-md hover:bg-[#28914e] cursor-pointer">
                    Transfer
                </button>
                <div class="bg-red-100 border-2 border-red-400 text-red-700 px-4 py-3 rounded-lg relative mt-3"
                     id="transferMessageView" style="display: none;">
                    <strong class="font-bold">Please correct the following errors:</strong>
                    <ul class="list-disc ml-5 mt-2" id="transferMessageList">
                    </ul>
                </div>
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
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"
                   required/>
            <p class="text-sm text-gray-600 mb-3">An OTP has been sent to your registered mobile/email.</p>
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
<script>
    const loadAccounts = async () => {
        try {
            const response = await fetch("${pageContext.request.contextPath}/load-my-accounts", {
                method: "POST",
            });

            if (response.ok) {
                const data = await response.json();

                const transferSelect = document.getElementById("transfer-account-select");
                const scheduledTransferSelect = document.getElementById("scheduled-transfer-account-select");
                const accountView = document.getElementById("accounts");
                const accountItem = document.getElementById("account");

                const option = '<option value="">Select Source Account</option>';

                if (data.success && data.accounts.length > 0) {
                    accountView.innerHTML = "";
                    transferSelect.innerHTML = "";
                    scheduledTransferSelect.innerHTML = "";

                    transferSelect.innerHTML = option;
                    scheduledTransferSelect.innerHTML = option;

                    data.accounts.forEach((account) => {
                        let clone = accountItem.cloneNode(true);
                        clone.querySelector("#account-type").innerHTML = account.accountType + " Account";
                        clone.querySelector("#account-no").innerHTML = "Account No: " + account.accountNumber;
                        clone.querySelector("#account-balance").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                            minimumFractionDigits: 2,
                        }).format(account.balance);

                        let accountOption1 = document.createElement("option");
                        accountOption1.classList.add("capitalize");
                        accountOption1.value = account.accountNumber;
                        accountOption1.innerHTML = account.accountType + " Account : " + account.accountNumber;

                        let accountOption2 = accountOption1.cloneNode(true);

                        transferSelect.appendChild(accountOption1);
                        scheduledTransferSelect.appendChild(accountOption2);
                        accountView.appendChild(clone);
                    });
                } else {
                    accountView.innerHTML = '<p class="font-semibold capitalize text-gray-500 py-5 text-center">No Accounts Found</p>';
                }
            }
        } catch (error) {
            console.error("Error:", error);
        }
    };

    const openModal = (id) => {
        document.getElementById(id).classList.remove('hidden');
    }

    const closeModal = (id) => {
        document.getElementById(id).classList.add('hidden');
    }

    document.getElementById("fundTransferForm").addEventListener("submit", async (e) => {
        e.preventDefault();

        const form = e.target;
        const formData = {
            fromAccount: form.transferAccountSelect.value,
            toAccount: form.transferToAccountNo.value,
            amount: form.transferAmount.value,
        };

        document.getElementById("transferMessageList").innerHTML = "";
        document.getElementById("transferMessageView").style.display = "none";

        try {
            const response = await fetch("${pageContext.request.contextPath}/validate-transfer", {
                method: "POST",
                body: JSON.stringify(formData),
            });

            if (response.ok) {
                const data = await response.json();

                if (data.success) {
                    document.getElementById("transferMessageView").style.display = "none";
                    document.getElementById("transfer-modal-amount").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(data.transferData.amount);
                    document.getElementById("transfer-modal-from-account-no").innerHTML = data.transferData.fromAccountNo;
                    document.getElementById("transfer-modal-to-account-no").innerHTML = data.transferData.toAccountNo;
                    document.getElementById("transfer-modal-to-name").innerHTML = data.transferData.toName;

                    openModal("confirmModal");
                } else {
                    const messageList = document.getElementById("transferMessageList");
                    for (const [field, message] of Object.entries(data.errors)) {
                        const li = document.createElement("li");
                        li.textContent = message;
                        li.classList.add("max-w-sm");
                        messageList.appendChild(li);
                    }

                    document.getElementById("transferMessageView").style.display = "block";
                }
            }
        } catch (error) {
            console.error("Error:", error);
            const messageList = document.getElementById("transferMessageList");
            const li = document.createElement("li");
            li.textContent = "An unexpected error occurred.";
            li.classList.add("max-w-sm");
            messageList.appendChild(li);
            document.getElementById("transferMessageView").style.display = "block";
        }
    });

    let otpVerify = false;
    let transferId = "";

    const transfer = async () => {
        const fromAcc = document.getElementById("transfer-account-select");
        const toAcc = document.getElementById("transfer-to-account-no");
        const amount = document.getElementById("transfer-amount");

        const formData = {
            fromAccount: fromAcc.value,
            toAccount: toAcc.value,
            amount: amount.value,
        };

        document.getElementById("transferMessageList").innerHTML = "";
        document.getElementById("transferMessageView").style.display = "none";

        try {
            const response = await fetch("${pageContext.request.contextPath}/fund-transfer", {
                method: "POST",
                body: JSON.stringify(formData),
            });

            if (response.ok) {
                const data = await response.json();

                if (data.success) {
                    document.getElementById("transferMessageView").style.display = "none";
                    document.getElementById("transfer-modal-otp-view").style.display = "block";
                    otpVerify = true;
                    transferId = data.transferId;
                } else {
                    const messageList = document.getElementById("transferMessageList");
                    for (const [field, message] of Object.entries(data.errors)) {
                        const li = document.createElement("li");
                        li.textContent = message;
                        li.classList.add("max-w-sm");
                        messageList.appendChild(li);
                    }

                    document.getElementById("transferMessageView").style.display = "block";
                }
            }
        } catch (error) {
            console.error("Error:", error);
            const messageList = document.getElementById("transferMessageList");
            const li = document.createElement("li");
            li.textContent = "An unexpected error occurred.";
            li.classList.add("max-w-sm");
            messageList.appendChild(li);
            document.getElementById("transferMessageView").style.display = "block";
        }
    };

    const verifyTransfer = async () => {
        const otp = document.getElementById("transfer-modal-otp");

        const formData = {
            transferId: transferId,
            otp: otp.value,
        };

        document.getElementById("transferMessageList").innerHTML = "";
        document.getElementById("transferMessageView").style.display = "none";

        try {
            const response = await fetch("${pageContext.request.contextPath}/verify-transfer", {
                method: "POST",
                body: JSON.stringify(formData),
            });

            if (response.ok) {
                const data = await response.json();

                if (data.success) {
                    document.getElementById("transferMessageView").style.display = "none";
                    document.getElementById("transfer-modal-otp-view").style.display = "none";
                    document.getElementById("transfer-account-select").value = "";
                    document.getElementById("transfer-to-account-no").value = "";
                    document.getElementById("transfer-amount").value = "";

                    otp.value = "";
                    otpVerify = false;
                    transferId = "";
                    closeModal("confirmModal");
                } else {
                    const messageList = document.getElementById("transferMessageList");
                    for (const [field, message] of Object.entries(data.errors)) {
                        const li = document.createElement("li");
                        li.textContent = message;
                        li.classList.add("max-w-sm");
                        messageList.appendChild(li);
                    }

                    document.getElementById("transferMessageView").style.display = "block";
                }
            }
        } catch (error) {
            console.error("Error:", error);
            const messageList = document.getElementById("transferMessageList");
            const li = document.createElement("li");
            li.textContent = "An unexpected error occurred.";
            li.classList.add("max-w-sm");
            messageList.appendChild(li);
            document.getElementById("transferMessageView").style.display = "block";
        }
    };

    const confirmTransfer = () => {
        if (!otpVerify) {
            transfer();
        } else {
            verifyTransfer();
        }
    };
</script>
</body>
</html>
