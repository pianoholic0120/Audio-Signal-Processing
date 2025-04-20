# Audio Signal Processing – Mid Project (Spring 2025)
國立臺灣大學《傅氏轉換與傅氏光學》課程專題

> Student ID: B10901151  
> Name: 林祐群  
> Duration: 9 seconds audio  
> Sampling Rate: 48,000 Hz  
> Channels: Stereo (Left/Right), 16-bit AAC, Recorded via OBS (Mac)  

---

## 📝 Project Overview

This project performs a series of audio signal processing tasks using MATLAB, focusing on both time and frequency domain analyses. The tasks follow **eight key problems**, including FFT, STFT, filtering, resampling for pitch shifting, and quantization analysis.

---

## 📂 Files Structure

| File Name         | Description                        |
|------------------|------------------------------------|
| `Project.m`       | MATLAB source code for all problems |
| `Project.m4a`     | Original audio file (9s, stereo)   |
| `Project.pdf`     | Full written report with plots and explanations |
| `README.md`       | This summary document              |

---

## 📊 Problem Breakdown

### **Problem 1 – Time-Domain Plot**
- Extracted left channel (`y(:,1)`) of stereo signal.
- Time vector calculated using sample rate.
- Plotted waveform over entire 9s duration.
- Normalized amplitude to [-1, 1] for consistent viewing.

---

### **Problem 2 – Sampling Rate Reduction**
- Original sample rate: **48,000 Hz**
- Tested downsampling by factors: **2, 4, 8** using `decimate`.
- Time-domain waveforms compared in fixed time range `[0.9, 0.92]`.
- Observation: lower sampling rates result in **loss of high-frequency details** and sparse waveform structures.

---

### **Problem 3 – Quantization Analysis**
- Original signal assumed to be 16-bit.
- Simulated quantization at **16-bit, 8-bit, and 4-bit** precision.
- Observation: **Lower bit-depth introduces step-like distortion** and loss of fidelity, especially in 4-bit case.

---

### **Problem 4 – FFT Spectrum**
- Used `fft()` to analyze frequency content.
- Observed energy mainly concentrated between **0–4kHz**, with minor components up to 12kHz.
- Frequencies beyond 12kHz show low amplitude (possible background or recording noise).
- Plotted both full and half-spectrum (Nyquist limit).

---

### **Problem 5 – Zero Padding**
- Applied zero-padding to double time-domain length.
- Compared original vs. zero-padded FFT results.
- Found **interpolation of spectrum improves visual frequency resolution**, but **true resolution unchanged**.

---

### **Problem 6 – STFT / Spectrogram**
- Window length: **1024 samples** → ≈ 21.3ms time window.
- Compared 4 configurations:
  - Hamming + 50% overlap
  - Hamming + 75% overlap
  - Hann + 50% overlap
  - Hann + 75% overlap
- Frequency resolution: **≈ 46.9 Hz**
- Time resolution (hop size):  
  - 50% → **10.7 ms**  
  - 75% → **5.3 ms**
- Trade-off observed between **time resolution** and **frequency clarity**.

---

### **Problem 7 – Noise Filtering**
- Designed a **6th-order Butterworth low-pass filter** with cutoff = 6kHz.
- Used `filtfilt()` for zero-phase filtering.
- Compared filtered vs. original in both time and frequency domains.
- Observed reduced high-frequency noise in frequency plot; audible difference was minor due to already clean recording.

---

### **Problem 8 – Pitch Shifting (Optional)**
- Used `resample(y, p, q)` to alter pitch:
  - `p=4, q=5` → **pitch up (0.8× slower signal)**
  - `p=5, q=4` → **pitch down (1.25× faster signal)**
- Played audio with original `Fs`, resulting in perceived **pitch shift and time speed change**.
- Mentioned that **independent pitch/time control** requires more advanced methods (e.g., phase vocoder).

---

## 📌 Appendix: Audio Metadata

- Format: MPEG-4 AAC  
- Sampling Rate: 48,000 Hz  
- Channels: Stereo (L & R)  
- Bit Depth: 16-bit  
- Source: OBS on macOS  

---

## ▶️ How to Run
1. Open `Project.m` in MATLAB.
2. Ensure audio file `Project.m4a` is in the same folder.
3. Uncomment each problem section one at a time to visualize and play results.
4. Use `sound()` to listen to original, filtered, or pitch-shifted versions.
