const openModal = (id) => {
    document.getElementById(id).classList.remove('hidden');
}

const closeModal = (id) => {
    document.getElementById(id).classList.add('hidden');
}

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