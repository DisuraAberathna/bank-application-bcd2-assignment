const loadAccounts = async () => {
    try {
        const response = await fetch("/bank-app/load-my-accounts", {
            method: "POST",
        });

        if (response.ok) {
            const data = await response.json();

            const transferSelect = document.getElementById("transfer-account-select");
            const scheduledTransferSelect = document.getElementById("scheduled-transfer-account-select");
            const accountList = document.getElementById("accountList");
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
                    let accountOption3;
                    if (data.accounts[0].accountNumber === account.accountNumber) {
                        accountOption3 = document.createElement("option");
                        accountOption3.classList.add("capitalize");
                        accountOption3.value = account.accountNumber;
                        accountOption3.innerHTML = account.accountType + " Account : " + account.accountNumber;
                        accountOption3.selected = true;
                    } else {
                        accountOption3 = accountOption1.cloneNode(true);
                    }

                    transferSelect.appendChild(accountOption1);
                    scheduledTransferSelect.appendChild(accountOption2);
                    accountList.appendChild(accountOption3);
                    accountView.appendChild(clone);
                });

                loadTransferHistory(data.accounts[0].accountNumber);
            } else {
                accountView.innerHTML = '<p class="font-semibold capitalize text-gray-500 py-5 text-center">No Accounts Found</p>';
            }
        }
    } catch (error) {
        console.error("Error:", error);
    }
};

const loadTransferHistory = async (val) => {
    const error = document.getElementById("transferHistoryError");
    const table = document.getElementById("transferHistoryTable");

    try {
        const response = await fetch("/bank-app/load-my-transfer-history", {
            method: "POST",
            body: JSON.stringify({
                accNo: val,
            }),
        });

        if (response.ok) {
            const data = await response.json();

            const tbody = document.getElementById("table-body");
            const trow = document.getElementById("table-row");

            if (data.success && data.transferHistory.length > 0) {
                table.classList.remove("hidden");
                error.classList.add("hidden");
                tbody.innerHTML = "";

                data.transferHistory.forEach(transferHistory => {
                    let clone = trow.cloneNode(true);
                    clone.querySelector("#table-date").innerHTML = formatDate(transferHistory.date);
                    clone.querySelector("#table-desc").innerHTML = transferHistory.description;
                    clone.querySelector("#table-amount").classList.add(transferHistory.isCreditor ? "text-green-600" : "text-red-600");
                    clone.querySelector("#table-amount").innerHTML = transferHistory.isCreditor ? "+" : "-" + "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(transferHistory.amount);
                    clone.querySelector("#table-balance").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(transferHistory.balance);

                    tbody.appendChild(clone);
                });
            } else {
                error.classList.remove("hidden");
                table.classList.add("hidden");
                error.innerHTML = '<p class="font-semibold capitalize text-gray-500 py-5 text-center">No Transfers Found</p>';
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

const sendTransfer = async (e) => {
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
        const response = await fetch("/bank-app/validate-transfer", {
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
};

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

    document.getElementById("transferModalMessageList").innerHTML = "";
    document.getElementById("transferModalMessageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/fund-transfer", {
            method: "POST",
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            const data = await response.json();

            if (data.success) {
                document.getElementById("transferModalMessageView").style.display = "none";
                document.getElementById("transfer-modal-otp-view").style.display = "block";
                otpVerify = true;
                transferId = data.transferId;
            } else {
                const messageList = document.getElementById("transferModalMessageList");
                for (const [field, message] of Object.entries(data.errors)) {
                    const li = document.createElement("li");
                    li.textContent = message;
                    li.classList.add("max-w-sm");
                    messageList.appendChild(li);
                }

                document.getElementById("transferModalMessageView").style.display = "block";
            }
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("transferModalMessageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("transferModalMessageView").style.display = "block";
    }
};

const verifyTransfer = async () => {
    const otp = document.getElementById("transfer-modal-otp");

    const formData = {
        transferId: transferId,
        otp: otp.value,
    };

    document.getElementById("transferModalMessageList").innerHTML = "";
    document.getElementById("transferModalMessageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/verify-transfer", {
            method: "POST",
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            const data = await response.json();

            if (data.success) {
                document.getElementById("transferModalMessageView").style.display = "none";
                document.getElementById("transfer-modal-otp-view").style.display = "none";
                document.getElementById("transfer-account-select").value = "";
                document.getElementById("transfer-to-account-no").value = "";
                document.getElementById("transfer-amount").value = "";

                otp.value = "";
                otpVerify = false;
                transferId = "";
                closeModal("confirmModal");
            } else {
                const messageList = document.getElementById("transferModalMessageList");
                for (const [field, message] of Object.entries(data.errors)) {
                    const li = document.createElement("li");
                    li.textContent = message;
                    li.classList.add("max-w-sm");
                    messageList.appendChild(li);
                }

                document.getElementById("transferModalMessageView").style.display = "block";
            }
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("transferModalMessageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("transferModalMessageView").style.display = "block";
    }
};

const confirmTransfer = () => {
    if (!otpVerify) {
        transfer();
    } else {
        verifyTransfer();
    }
};

const transferReset = () => {
    otpVerify = false;
    transferId = "";
    document.getElementById("transferMessageView").style.display = "none";
    document.getElementById("transferModalMessageView").style.display = "none";
    document.getElementById("transfer-modal-otp-view").style.display = "none";
    document.getElementById("transfer-modal-otp").value = "";
    document.getElementById("transfer-account-select").value = "";
    document.getElementById("transfer-to-account-no").value = "";
    document.getElementById("transfer-amount").value = "";
};

const sendScheduleTransfer = async (e) => {
    e.preventDefault();

    const form = e.target;
    const formData = {
        fromAccount: form.scheduledAccountSelect.value,
        toAccount: form.scheduledAccountNo.value,
        amount: form.scheduledAmount.value,
        date: form.scheduledDate.value,
    };

    document.getElementById("scheduledTransferMessageList").innerHTML = "";
    document.getElementById("scheduledTransferMessageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/validate-schedule-transfer", {
            method: "POST",
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            const data = await response.json();

            if (data.success) {
                document.getElementById("scheduledTransferMessageView").style.display = "none";
                document.getElementById("scheduled-modal-amount").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2,
                }).format(data.transferData.amount);
                document.getElementById("scheduled-modal-from-account-no").innerHTML = data.transferData.fromAccountNo;
                document.getElementById("scheduled-modal-to-account-no").innerHTML = data.transferData.toAccountNo;
                document.getElementById("scheduled-modal-to-name").innerHTML = data.transferData.toName;
                document.getElementById("scheduled-modal-date").innerHTML = formatDate(data.transferData.scheduledDate);

                openModal("confirmScheduleModal");
            } else {
                const messageList = document.getElementById("scheduledTransferMessageList");
                for (const [field, message] of Object.entries(data.errors)) {
                    const li = document.createElement("li");
                    li.textContent = message;
                    li.classList.add("max-w-sm");
                    messageList.appendChild(li);
                }

                document.getElementById("scheduledTransferMessageView").style.display = "block";
            }
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("scheduledTransferMessageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("scheduledTransferMessageView").style.display = "block";
    }
};

let scheduleOtpVerify = false;
let scheduledTransferId = "";

const scheduleTransfer = async () => {
    const fromAcc = document.getElementById("scheduled-transfer-account-select");
    const toAcc = document.getElementById("scheduled-transfer-to-account-no");
    const amount = document.getElementById("scheduled-transfer-amount");
    const date = document.getElementById("scheduled-transfer-date-time");

    const formData = {
        fromAccount: fromAcc.value,
        toAccount: toAcc.value,
        amount: amount.value,
        date: date.value,
    };

    document.getElementById("scheduledModalMessageList").innerHTML = "";
    document.getElementById("scheduledModalMessageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/schedule-fund-transfer", {
            method: "POST",
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            const data = await response.json();

            if (data.success) {
                document.getElementById("scheduledModalMessageView").style.display = "none";
                document.getElementById("scheduled-modal-otp-view").style.display = "block";
                scheduleOtpVerify = true;
                scheduledTransferId = data.transferId;
            } else {
                const messageList = document.getElementById("scheduledModalMessageList");
                for (const [field, message] of Object.entries(data.errors)) {
                    const li = document.createElement("li");
                    li.textContent = message;
                    li.classList.add("max-w-sm");
                    messageList.appendChild(li);
                }

                document.getElementById("scheduledModalMessageView").style.display = "block";
            }
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("scheduledModalMessageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("scheduledModalMessageView").style.display = "block";
    }
};

const verifyScheduleTransfer = async () => {
    const otp = document.getElementById("scheduled-modal-otp");

    const formData = {
        transferId: scheduledTransferId,
        otp: otp.value,
    };

    document.getElementById("scheduledModalMessageList").innerHTML = "";
    document.getElementById("scheduledModalMessageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/verify-schedule-transfer", {
            method: "POST",
            body: JSON.stringify(formData),
        });

        if (response.ok) {
            const data = await response.json();

            if (data.success) {
                document.getElementById("scheduledModalMessageView").style.display = "none";
                document.getElementById("scheduled-modal-otp-view").style.display = "none";
                document.getElementById("scheduled-transfer-account-select").value = "";
                document.getElementById("scheduled-transfer-to-account-no").value = "";
                document.getElementById("scheduled-transfer-amount").value = "";
                document.getElementById("scheduled-transfer-date-time").value = "";

                otp.value = "";
                scheduleOtpVerify = false;
                scheduledTransferId = "";
                closeModal("confirmScheduleModal");
            } else {
                const messageList = document.getElementById("scheduledModalMessageList");
                for (const [field, message] of Object.entries(data.errors)) {
                    const li = document.createElement("li");
                    li.textContent = message;
                    li.classList.add("max-w-sm");
                    messageList.appendChild(li);
                }

                document.getElementById("scheduledModalMessageView").style.display = "block";
            }
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("scheduledModalMessageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("transferModalMessageView").style.display = "block";
    }
};

const confirmScheduleTransfer = () => {
    if (!scheduleOtpVerify) {
        scheduleTransfer();
    } else {
        verifyScheduleTransfer();
    }
};

const scheduleTransferReset = () => {
    scheduleOtpVerify = false;
    scheduledTransferId = "";
    document.getElementById("scheduledTransferMessageView").style.display = "none";
    document.getElementById("scheduledModalMessageView").style.display = "none";
    document.getElementById("scheduled-modal-otp-view").style.display = "none";
    document.getElementById("scheduled-modal-otp").value = "";
    document.getElementById("scheduled-transfer-account-select").value = "";
    document.getElementById("scheduled-transfer-to-account-no").value = "";
    document.getElementById("scheduled-transfer-amount").value = "";
    document.getElementById("scheduled-transfer-date-time").value = "";
};

const formatDate = (dateTime) => {
    const date = new Date(dateTime);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    let hours = date.getHours();
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';

    hours = hours % 12;
    hours = hours ? hours : 12;
    const formattedHour = String(hours).padStart(2, '0');

    return `${year}-${month}-${day} ${formattedHour}.${minutes} ${ampm}`;
}