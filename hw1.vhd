library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW1 is
    Port (
        i_clk     : in  std_logic;
        i_rst_n   : in  std_logic;
        i_limit   : in  std_logic_vector(7 downto 0);
        o_count   : out std_logic_vector(7 downto 0)
    );
end HW1;

architecture Behavioral of HW1 is
    signal tmp        : unsigned(25 downto 0) := (others => '0');  -- 26-bit ���W�μȦs��
    signal slow_clk   : std_logic := '0';
    signal count_reg  : unsigned(7 downto 0) := (others => '0');
    signal limit      : unsigned(7 downto 0);
begin
    -- �h�줸���W��
    process(i_clk, i_rst_n)
    begin
        if i_rst_n = '0' then
            tmp <= (others => '0');
        elsif rising_edge(i_clk) then
            tmp <= tmp + 1;
        end if;
    end process;

    slow_clk <= tmp(24);  -- �令 tmp(1) �i�H�[�t����

    -- �D�p���޿�
    limit <= unsigned(i_limit);

    process(slow_clk, i_rst_n)
    begin
        if i_rst_n = '0' then
            count_reg <= (others => '0');
        elsif rising_edge(slow_clk) then
            if count_reg + 4 >= limit then
                count_reg <= (others => '0');
            else
                count_reg <= count_reg + 4;
            end if;
        end if;
    end process;

    -- ��X
    o_count <= std_logic_vector(count_reg);
end Behavioral;
