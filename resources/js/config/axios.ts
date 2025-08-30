import axios from 'axios';

export const BASE_API = axios.create({
  baseURL: import.meta.env.VITE_BASE_URL,
});

// 🔍 Interceptor para mostrar todas las respuestas
BASE_API.interceptors.response.use(
  (response) => {
    console.log(`[✅ RESPONSE] ${response.config.url}`, response.data);
    return response;
  },
  (error) => {
    console.error(`[❌ ERROR] ${error.config?.url}`, error.response?.data || error.message);
    return Promise.reject(error);
  },
);

export default { BASE_API };
