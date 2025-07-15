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
};