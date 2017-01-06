/** @flow */
export function post(endpoint, payload) {
    return fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(payload),
        credentials: 'same-origin',
        headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json'
        },
    }).then(res => {
        if (res.status === 201)
          return res.json();
        return Promise.reject(new Error(res.statusText));
    });
}

export function update(endpoint, payload, token) {
    return fetch(endpoint + payload.id, {
        method: 'PUT',
        body: JSON.stringify({...payload, authenticity_token: token}),
        credentials: 'same-origin',
        headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json'
        },
    }).then(res => {
        if (res.status === 200)
          return res.json();
        return Promise.reject(new Error(res.statusText));
    });
}

export function delete_(endpoint, id, token) {
    return fetch(endpoint + id, {
        method: 'DELETE',
        credentials: 'same-origin',
        headers: {
           'Content-Type': 'application/json',
            Accept: 'application/json'
        },
        body: JSON.stringify({ authenticity_token: token }),
    }).then(res => {
        if (res.status === 204)
          return res.text();
        return Promise.reject(new Error(res.statusText));
    });
}