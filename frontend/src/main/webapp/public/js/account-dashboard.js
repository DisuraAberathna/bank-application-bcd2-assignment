const loadAccounts = async () => {
    try {
        const response = await fetch("load-my-accounts", {
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

    const response = await fetch("validate-transfer", {
        method: "POST",
    });
});