`timescale 1ns / 1ps

module tb_ntt;
    // Parameters
    parameter int q = 8380417;

    // DUT inputs and outputs
    logic clk, rst, start;
    logic signed [63:0] w [0:255];
    logic signed [63:0] w_hat [0:255];
//    logic done;

    // Clock generation
    initial begin
        clk = 0;
        forever #0.4 clk = ~clk; // 100 MHz clock
    end

    // DUT instantiation
    NTT_64 #(.WIDTH(64)) uut (
        .clk(clk),
        .rst(rst),
        .w(w),
        .w_hat(w_hat)
//        .done(done
    );

    // Testbench logic
    initial begin
        // Initialize inputs
        #3
        rst = 1;
        start = 0;
        w = '{64'h1318a7973e00, 64'h63d392fca7a, 64'h22ac12398498, 64'h10af833be6d, 64'h19c4fc9c8938, 64'h14498f9450b6, 64'h119680bd4b8, 64'h12545a4d24, 64'h7fd41940775, 64'hcbb0568016, 64'h20f7013a4cc1, 64'h11a9ac7719b2, 64'h13595b7cecf, 64'h75f737f145f, 64'h16cdaad75cf6, 64'h1bbc9a9c8fa, 64'h8ec2c6c59ee, 64'h8bbf6fbea8, 64'h1f2ba7c9b18f, 64'hd921dd09000, 64'h7b7e445864f, 64'h86b0bbd0210, 64'hcab089f0d84, 64'h1f2338b3dbf3, 64'h1592014f0674, 64'h5235a302776, 64'h3a981f0ba24, 64'h5ed705916e4, 64'h22974bd26e8, 64'h61677be4aac, 64'ha91ea2f205, 64'hb69333d7c49, 64'h19717dd60f21, 64'h139c22125da0, 64'h27bca331bbd7, 64'h484dcf4528, 64'h26655d1a9bb0, 64'h177c4da91032, 64'h272a4991dc18, 64'h59da5bd6bcd, 64'h9457dcbc566, 64'h17c2a3028438, 64'h19442d1f766c, 64'he98c9e39b48, 64'h1fe32c4aeff, 64'h238fb9e9f40, 64'h1a66439d1fe4, 64'h12d7508743ee, 64'h19636a51e466, 64'hac2e8c80ea1, 64'h1e577ca32338, 64'hdf92260d692, 64'h26b09b751c9c, 64'h108ae7ee5110, 64'h2c0b8e288600, 64'h2a16ca7e5a6, 64'h635cc744a70, 64'h149128b23e8c, 64'h77c38d1cf41, 64'h2cbf7eb78, 64'h2cb08a1f8598, 64'h62b3923d76, 64'h14558b7aed6f, 64'h1ffa90f2440, 64'h4f1036ff1c6, 64'hf2bc89ba575, 64'h13ebd4b9ff76, 64'hd582403229, 64'h103a54a49300, 64'h1bd09ae9586, 64'hbcc31e56b28, 64'h24f6b08e2dba, 64'hf19215f4900, 64'hb9774ee333, 64'h7040c3c066, 64'h21347c55e1b0, 64'h4e72b91be42, 64'h7bccd0cfe66, 64'h55711d1e2ab, 64'ha718042d3a0, 64'h277c6c8995f4, 64'h3d17adbb54, 64'hcb9bbcb4c90, 64'h87cb89c554, 64'h3bc3530e333, 64'h2e34ab0de86a, 64'h69bb97e42aa, 64'h1a684ece3078, 64'h358397e1667, 64'h27006710a0, 64'h6ce83caed00, 64'h8634f1ab38, 64'hba379d2dca, 64'h11507eb8cd76, 64'h1fa7c8f51e3b, 64'h52d222ad8aa, 64'h1e72d62e5164, 64'h28bd2b91bc82, 64'h291d6abf4846, 64'hdd268d8eb8, 64'h36a07809e70, 64'habea9d0e0d0, 64'h1026394e9a2f, 64'h7c441e55c7d, 64'hd7f9db90166, 64'h1152f197e2a8, 64'h40d036ee6eb, 64'h1a5002836cc2, 64'h1ce4cc096840, 64'h2e605e69d2, 64'h1503ae6495ec, 64'h40efb4baf08, 64'h2022776096cd, 64'hc95b1c5d98, 64'h10aa86b2a470, 64'he5502f7d878, 64'h93e47192f36, 64'h79e0b25c034, 64'h25d3f3a3eb1, 64'h1bb299e9d9cc, 64'hbd5e950964b, 64'h40d661f342c, 64'ha40714cc, 64'h62060d35d20, 64'h225bbbd14c8, 64'h371b5f62c1c, 64'h12a19af68ae0, 64'h1931b33e670c, 64'h1edb82ad8fa, 64'h4ca71142638, 64'h2fd488635e8e, 64'hb19b36ec518, 64'h142f8b4518c4, 64'h5e71022f20, 64'h1cc2e599dd0, 64'hb7704292918, 64'h2b757a94d56, 64'h3e9051af2de, 64'h283a0c183221, 64'h139049321b67, 64'h23dd3bcd8b68, 64'h1872c9f0b36d, 64'h553c4758394, 64'h22e1d354fcab, 64'h70666d1f9ed, 64'h10dc690b32c2, 64'h37469b3acb4, 64'hbd56762f820, 64'h18761cf96b18, 64'h524e12cd14, 64'h1a9ad1b7a3f, 64'he2a80239eda, 64'h6431b8163c0, 64'h3cbfa03c090, 64'h1ac74c79e806, 64'h28d08d8ee74, 64'h1ed55bacb80, 64'h9068373b6b8, 64'h1e3e5462387, 64'h212346ac03c0, 64'h738cd38d065, 64'h2312a30c0d02, 64'h4a156ccc53e, 64'h307c713330, 64'h1263ba131970, 64'h11f95b1e510, 64'h58152352092, 64'h17f37373a0a0, 64'h7285cb835a8, 64'h182ebdcbba15, 64'h5c8b5399b04, 64'h1889000b7dc, 64'h83b5cc555a4, 64'h16e4ccdfc6e0, 64'h355c4437b4b9, 64'h122f2b98c45, 64'h13e44cc8820a, 64'h10aeb6b293ef, 64'h13df54c81ef5, 64'hbc82c87c18b, 64'h9574ca09b35, 64'h3bd81c7f438, 64'h355ac4a2ba0, 64'h1de0448105a, 64'h8a3ed8424f8, 64'h282b64366f, 64'hb77bab99636, 64'h1e4a60afd9f6, 64'hb2446d77f95, 64'h9b9b519d907, 64'h1bd6f55407, 64'h127329f00c3f, 64'habf1192afe2, 64'h72d7daecc6b, 64'h37b43be1530, 64'h2aa7279b914f, 64'h22a1dd702d1, 64'he258c9e8015, 64'h15307b6a0c54, 64'h15522894ac3e, 64'h185034e551ae, 64'h5c368e11a28, 64'h5591dc1ad80, 64'hcb6510c0a68, 64'h35ba586add90, 64'h6cfd9296af2, 64'h81c7b5eacc8, 64'h13eb284a26f0, 64'h12e3d30e1dab, 64'h1a256a07737c, 64'h16ef26831892, 64'h12b5c320f307, 64'h3516b9b9ff44, 64'h4018a60ad8d, 64'h347324bf49d, 64'h16997562e4c0, 64'h15988fe3b466, 64'heb898276840, 64'h223d675ae4f, 64'hb30713ee7a5, 64'hda26ef4e7f0, 64'ha40311cb850, 64'hbfb1ccc6cfa, 64'h2516493a98ee, 64'h8062842426, 64'hcb11602c15, 64'h1c35c8623484, 64'h182a06d13659, 64'hf149ebc13da, 64'h1d44c1df1f7a, 64'hf7d8bccede, 64'h11e47e08365c, 64'haeadf3e7da8, 64'h13610abb64fc, 64'h6bf0fc1527b, 64'h1d9e100538, 64'h3814f87c2c9, 64'h2c9be9e2e30, 64'h1d96b948543a, 64'h39b5419d2a53, 64'h38591e7d6081, 64'h2872c712cedc, 64'heb4c78425ea, 64'h9ac210b5fa, 64'hfb24405ae68, 64'h1ab157bc14d5, 64'h15fa514c840, 64'h5000a34d967, 64'h1b911c61efa, 64'h1693b3a85c, 64'h22945b9ad974, 64'h777fe105dc, 64'h272553da63b0, 64'h112e67a35542, 64'h1c9b3b3bfb32, 64'h378de5640918};

        // Apply reset
        #1 rst = 0;

        // Start the NTT computation
        start = 1;
//        #10 start = 1;

        // Wait for completion
//        wait(done);

        // Display results
//        $display("NTT computation complete.");
//        for (int i = 0; i < 256; i++) begin
//            $display("w_hat[%0d] = %0d", i, w_hat[i]);
//        end

        // End simulation
        #1000 $stop;
    end
endmodule
