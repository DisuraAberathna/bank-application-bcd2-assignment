const addCustomer = async (e) => {
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
        const response = await fetch("/bank-app/add-customer", {
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
};

const loadCustomer = async () => {
    const nic = document.getElementById("s-nic");

    document.getElementById("s-messageList").innerHTML = "";
    document.getElementById("s-messageView").style.display = "none";

    try {
        const response = await fetch("/bank-app/load-customer", {
            method: "POST",
            body: JSON.stringify({
                nic: nic.value,
            }),
        });

        const tbody = document.getElementById("c-tbody");
        const trow = document.getElementById("c-trow");

        const data = await response.json();
        if (data.success && data.customer && data.accounts.length > 0) {
            document.getElementById("s-messageView").style.display = "none";

            document.getElementById("c-name").innerHTML = data.customer.name;
            document.getElementById("c-email").innerHTML = data.customer.email;
            document.getElementById("c-nic").innerHTML = data.customer.nic;
            document.getElementById("c-mobile").innerHTML = data.customer.mobile;

            tbody.innerHTML = "";

            data.accounts.forEach(account => {
                let clone = trow.cloneNode(true);
                clone.querySelector("#c-accNo").innerHTML = account.accountNumber;
                clone.querySelector("#c-type").innerHTML = account.accountType;
                clone.querySelector("#c-balance").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2,
                }).format(account.balance);
                clone.querySelector("#c-lTransaction").innerHTML = account.lastTransactionDate;

                tbody.appendChild(clone);
            });

            openModal("customerDetailsModal");
        } else {
            const messageList = document.getElementById("s-messageList");
            for (const [field, message] of Object.entries(data.errors)) {
                const li = document.createElement("li");
                li.textContent = message;
                li.classList.add("max-w-sm");
                messageList.appendChild(li);
            }

            document.getElementById("s-messageView").style.display = "block";
        }
    } catch (error) {
        console.error("Error:", error);
        const messageList = document.getElementById("s-messageList");
        const li = document.createElement("li");
        li.textContent = "An unexpected error occurred.";
        li.classList.add("max-w-sm");
        messageList.appendChild(li);
        document.getElementById("s-messageView").style.display = "block";
    }
};